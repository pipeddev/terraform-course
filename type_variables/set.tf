# Variables de tipo set
# Set no admite elementes duplicados
# Set no admite el acceso a los elementos por su posicion
variable "set_cidrs" {
  default = ["10.10.0.0/16", "10.20.0.0/16"]
  type    = set(string)
}

# Uso set

resource "aws_vpc" "vpc" {
  for_each   = var.set_cidrs
  cidr_block = each.value
  tags = {
    Name = "VPC_TEST"
    name = "prueba"
    env  = "Dev"
  }

}