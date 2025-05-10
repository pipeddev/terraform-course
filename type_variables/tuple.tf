# Tipo variable  tupla
variable "ohio" {
  type    = tuple([string, string, number, bool, string])
  default = ["Ohio", "10.20.0.0/16", 1, false, "Dev"]
}

# Uso de la variable tupla
resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio[1]
  tags = {
    Name = var.ohio[0]
    name = var.ohio[0]
    env  = var.ohio[4]
  }
  provider = aws.ohio
}