#!/bin/bash
cp dot-terraform.rc $HOME/.terraformrc
d=`pwd`
sleep 5

reg=$1
if [[ -z ${reg} ]] ; then
    echo "no terraform output variables - exiting ....."
    echo "run terraform init/plan/apply in the the init directory first"
else
    echo "region=$reg"
fi

s3b=$(echo "aws_s3_bucket.awsb-s3.id" | terraform console 2> /dev/null)

echo $s3b > tmp-buck.txt
echo $reg
mkdir -p generated

SECTIONS=('user' 'vpc' 'security' 'role' 'key' 'eks' 'db' 'ec2' 'efs')
 
for section in "${SECTIONS[@]}"
do

    tabn=$(printf "terraform-tfstate-lock-%s" $section) 
    s3b=`terraform output -json s3_bucket`
    
    echo $s3b $tabn

    cd $d

    of=`echo "generated/version-${section}.tf"`

    # write out the backend config 
    printf "" > $of
    printf "terraform {\n" >> $of
    printf "required_version = \"~> 1.3.0\"\n" >> $of
    printf "required_providers {\n" >> $of
    printf "  aws = {\n" >> $of
    printf "   source = \"hashicorp/aws\"\n" >> $of
    printf "#  Lock version to avoid unexpected problems\n" >> $of
    printf "   version = \"4.31.0\"\n" >> $of
    printf "  }\n" >> $of
    printf "  kubernetes = {\n" >> $of
    printf "   source = \"hashicorp/kubernetes\"\n" >> $of
    printf "   version = \"2.13.1\"\n" >> $of
    printf "  }\n" >> $of
    printf " }\n" >> $of
    printf "backend \"s3\" {\n" >> $of
    printf "bucket = %s\n"  $s3b >> $of
    printf "key = \"terraform/%s/terraform.tfstate\"\n"  $tabn >> $of
    printf "region = \"%s\"\n"  $reg >> $of
    printf "dynamodb_table = \"%s\"\n"  $tabn >> $of
    printf "encrypt = \"true\"\n"   >> $of
    printf "}\n" >> $of
    printf "}\n" >> $of
    ##
    printf "provider \"aws\" {\n" >> $of
    printf "region = \"ap-northeast-2\"\n"  >> $of
    printf "profile = \"mfa\"\n" >> $of
    printf "}\n" >> $of

done
cd $d


cp -f generated/version-user.tf ../3.user
cp -f generated/version-vpc.tf ../4.vpc
cp -f generated/version-security.tf ../5.security
cp -f generated/version-role.tf ../6.role
cp -f generated/version-key.tf ../7.key
cp -f generated/version-eks.tf ../8.eks
cp -f generated/version-db.tf ../9.db
cp -f generated/version-ec2.tf ../10.ec2
cp -f generated/version-efs.tf ../11.efs



cd ~/environment/jw_trf
terraform fmt --recursive > /dev/null
exit 0
