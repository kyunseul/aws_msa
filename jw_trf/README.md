사용 전에 꼭 읽고 사용 !!

Order to apply
1. s3
2. dynamo
3. iamuser
4. vpc
5. security / role / key
6. eks
7. ec2

#####
defalut Region = "ap-northeast-2"
defalut profile = "mfa"

#####
if you want to change region and profile, you can edit 59,60 Line jw_trf/1.s3/gen_version.sh 

##### 
mfa 인증 진행 후 해야 함

###
3.user에서 apply할 때마다 ~/.aws/credentials에 키값이 추가되기 때문에 다 쓰고 지워줘야 함

###
bastion에서 mgmt 서버로 접속하는 방법은 각자 선택 ex)scp로 키 전송

###
terraform init -reconfigure


Essential command !!!!!!!!!
###[1.s3] directory###


chmod +x gen_version.sh


###[7.key] directory###


ssh-keygen -m PEM -f mykey -N ""


현재 보안그룹 인바운드 규칙은 0.0.0.0/0으로 설정되어 있음
