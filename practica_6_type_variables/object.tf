# Variable tipo object
variable "virginia" {
  type = object({
    nombre     = string
    cantidad   = number
    cidrs      = list(string)
    disponible = bool
    env        = string
    owner      = string
  })

  default = {
    cantidad   = 1
    cidrs      = ["10.10.0.0/16"]
    disponible = true
    env        = "Dev"
    nombre     = "Virginia"
    owner      = "Felipe"
  }
}

# Uso de la variable object
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia.cidrs[0]
  tags = {
    Name  = var.virginia.nombre
    name  = var.virginia.nombre
    env   = var.virginia.env
    owner = var.virginia.owner
  }

}