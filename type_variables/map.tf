# Variables de tipo map
variable "map_cidrs" {
  default = {
    virginia = "10.10.0.0/16"
    ohio     = "10.20.0.0/16"
  }
  type = map(string)
}


# Uso map

resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.map_cidrs["virginia"]
  tags = {
    Name = "VPC_VIRGINIA"
    name = "prueba"
    env  = "Dev"
  }
}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.map_cidrs["ohio"]
  tags = {
    Name = "VPC_OHIO"
    name = "prueba"
    env  = "Dev"
  }
  provider = aws.ohio
}

# Uso de for_each
resource "aws_vpc" "vpc" {
  for_each   = var.map_cidrs
  cidr_block = each.value
  tags = {
    Name = "VPC_TEST"
    name = "prueba"
    env  = "Dev"
  }
}