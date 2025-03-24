resource "aws_vpc" "private" {
  cidr_block = var.cidr

  tags = {
    Name= "${var.env}-vpc-private"
  }
}