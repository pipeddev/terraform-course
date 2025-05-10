variable "virginia_cidr" {
  default     = "10.10.0.0/16"
  description = "CIDR block for Virginia region"
  type        = string
  sensitive   = false
}

variable "ohio_cidr" {
  default     = "10.20.0.0/16"
  description = "CIDR block for Ohio region"
  type        = string
  sensitive   = true # true -> no se muestra el valor
}

# variables Basicas

# string -> "Este es un ejemplo" o "10.0.0.0/12"
# number -> 10
# bool -> true
# any -> Cualquier tipo de dato