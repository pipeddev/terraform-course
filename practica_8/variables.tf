variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# variable "public_subnet" {
#   description = "CIDR Public Subnet"
#   type        = string
# }

# variable "private_subnet" {
#   description = "CIDR Private Subnet"
#   type        = string
# }

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}