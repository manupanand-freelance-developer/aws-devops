# subnets for vpc
resource "aws_subnet" "public-subnets" {
  vpc_id        =   aws_vpc.private.id 
  cidr_block    =   var.public_subnets

  tags={
    Name="${var.env}-public-subnet"
  } 
}
resource "aws_subnet" "kube-subnets" {
  vpc_id        =   aws_vpc.private.id 
  cidr_block    =   var.kube_subnets

  tags={
    Name="${var.env}-kube-subnet"
  } 
}
resource "aws_subnet" "db-subnets" {
  vpc_id        =   aws_vpc.private.id 
  cidr_block    =   var.db_subnets

  tags={
    Name="${var.env}-db-subnet"
  } 
}