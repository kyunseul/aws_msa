# vpc
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "AWSb-ap2-vpc"
  }
}
# internet_gatewawy
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "AWSb-ap2-igw"
  }
}

# public_subnet
resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "AWSb-ap2-pub-sub-2a",
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "pub_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "AWSb-ap2-pub-sub-2c",
    "kubernetes.io/role/elb" = "1"
  }
}
#public_route_table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "AWSb-rtb-public"
  }
}
#public_association
resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "pub_c" {
  subnet_id      = aws_subnet.pub_c.id
  route_table_id = aws_route_table.public_rtb.id
}

# private_subnet
resource "aws_subnet" "mgmt_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "AWSb-ap2-mgmt-sub-2a"
  }
}
resource "aws_subnet" "mgmt_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "AWSb-ap2-mgmt-sub-2c"
  }
}
resource "aws_subnet" "node_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "AWSb-pri-ap2-node-sub-2a"
  }
}
resource "aws_subnet" "node_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "AWSb-ap2-pri-node-sub-2c"
  }
}
resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.13.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "AWSb-pri-ap2-db-sub-2a"
  }
}
resource "aws_subnet" "db_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.23.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "AWSb-pri-ap2-db-sub-2c"
  }
}

# private_route_table + nat
resource "aws_route_table" "private_rtb_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw_a.id
  }

  tags = {
    Name = "tf-rtb-private_a"
  }
}
resource "aws_route_table" "private_rtb_c" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw_c.id
  }

  tags = {
    Name = "tf-rtb-private_c"
  }
}

#private_association
resource "aws_route_table_association" "mgmt_a" {
  subnet_id      = aws_subnet.mgmt_a.id
  route_table_id = aws_route_table.private_rtb_a.id
}
resource "aws_route_table_association" "node_a" {
  subnet_id      = aws_subnet.node_a.id
  route_table_id = aws_route_table.private_rtb_a.id
}
resource "aws_route_table_association" "db_a" {
  subnet_id      = aws_subnet.db_a.id
  route_table_id = aws_route_table.private_rtb_a.id
}
resource "aws_route_table_association" "mgmt_c" {
  subnet_id      = aws_subnet.mgmt_c.id
  route_table_id = aws_route_table.private_rtb_c.id
}
resource "aws_route_table_association" "node_c" {
  subnet_id      = aws_subnet.node_c.id
  route_table_id = aws_route_table.private_rtb_c.id
}
resource "aws_route_table_association" "db_c" {
  subnet_id      = aws_subnet.db_c.id
  route_table_id = aws_route_table.private_rtb_c.id
}

#eip
resource "aws_eip" "pub_a" {
  vpc = true
  tags = {
    Name = "AWSb-ap2-natgw-eip-2a"
  }
}
resource "aws_eip" "pub_c" {
  vpc = true
  tags = {
    Name = "AWSb-ap2-natgw-eip-2c"
  }
}

#nat_gateway
resource "aws_nat_gateway" "gw_a" {
  allocation_id = aws_eip.pub_a.id
  subnet_id     = aws_subnet.pub_a.id

  tags = {
    Name = "tf-nat-public1-ap-northeast-2a"
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "gw_c" {
  allocation_id = aws_eip.pub_c.id
  subnet_id     = aws_subnet.pub_c.id

  tags = {
    Name = "tf-nat-public1-ap-northeast-2a"
  }
  depends_on = [aws_internet_gateway.igw]
}