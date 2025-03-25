resource "aws_route_table" "public-subnets" {
  vpc_id   = aws_vpc.private.id


  # route associate for internet gate way
  route {
    cidr_block =  "0.0.0.0/0"
    gateway_id = aws_internet_gateway.private-vpc-igw.id 
  }

  # attch peering connection 
  route{
    cidr_block                  =  var.default_vpc_cidr
    vpc_peering_connection_id   =  aws_vpc_peering_connection.default-private-peering.id
  }

  tags={
    Name="${var.env}-public-subnet-rt"
  }
}
resource "aws_route_table" "kube-subnets" {
  vpc_id   = aws_vpc.private.id


  # attach route nat gateway
  route{
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.pubiic-subnet-ntgw.id
  }

  # attch peering connection 
  route{
    cidr_block                  =  var.default_vpc_cidr
    vpc_peering_connection_id   =  aws_vpc_peering_connection.default-private-peering.id
  }


  tags={
    Name="${var.env}-kube-subnet-rt"
  }
}
resource "aws_route_table" "db-subnets" {
  vpc_id   = aws_vpc.private.id


  # attach route nat gateway
  route{
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.pubiic-subnet-ntgw.id
  }

  # attch peering connection 
  route{
    cidr_block                  =  var.default_vpc_cidr
    vpc_peering_connection_id   =  aws_vpc_peering_connection.default-private-peering.id
  }

  tags={
    Name="${var.env}-db-subnet-rt"
  }
}
# associate route tables with subnets
resource "aws_route_table_association" "public-subnets-asso" {
    depends_on = [ aws_route_table.public-subnets ]
    subnet_id         = aws_subnet.public-subnets.id 
    route_table_id    = aws_route_table.public_subnets.id  

   
}
resource "aws_route_table_association" "kube-subnets-asso" {
    depends_on = [ aws_route_table.kube-subnets ]
    subnet_id         = aws_subnet.kube-subnets.id 
    route_table_id = aws_route_table.kube-subnets.id

   
}
resource "aws_route_table_association" "db-subnets-asso" {
  depends_on = [ aws_route_table.db-subnets ]
    subnet_id         = aws_subnet.db-subnets.id 
    route_table_id    = aws_route_table.db-subnets.id

   
}