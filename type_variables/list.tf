# Variables de tipo list
variable "list_cidrs" {
  default = ["10.10.0.0/16", "10.20.0.0/16"]
  #           position 0       position 1
  type = list(string) # tambien se puede usar el tipo de dato number
}


# Uso list
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.list_cidrs[0]
  tags = {
    Name = "VPC_VIRGINIA"
    name = "prueba"
    env  = "Dev"
  }
}
resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.list_cidrs[1]
  tags = {
    Name = "VPC_OHIO"
    name = "prueba"
    env  = "Dev"
  }
  provider = aws.ohio
}
# Uso de for_each
resource "aws_vpc" "vpc" {
  for_each   = toset(var.list_cidrs)
  cidr_block = each.value
  tags = {
    Name = "VPC_TEST"
    name = "prueba"
    env  = "Dev"
  }
}