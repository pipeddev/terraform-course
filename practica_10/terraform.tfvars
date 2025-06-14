virginia_cidr = "10.10.0.0/16"

# se generó este map con el objetivo de utilizar workspaces y poder crear diferentes CIDR para cada workspace.
# virginia_cidr = {
#   "prod" = "10.10.0.0/16"
#   "dev"  = "172.16.0.0/16"
# }

# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "env"         = "dev"
  "owner"       = "Felipe"
  "cloud"       = "aws"
  "IAC"         = "terraform"
  "IAC_VERSION" = "1.11.4"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
}

enable_monitoring = 0

ingress_port_list = [22, 80, 443]