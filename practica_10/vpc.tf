resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # se utiliza cuando utilizamos workspaces
  #cidr_block = lookup(var.virginia_cidr,terraform.workspace)
  tags = {
    "Name" = "vpc_virginia-${local.suffix}" # vpc_virginia_temp
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.suffix}" # public_subnet_temp
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "private_subnet-${local.suffix}" # private_subnet_temp
  }
  # ejemplo de dependencia explicita.
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.suffix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt-${local.suffix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}



# Use aws_vpc_security_group_ingress_rule for each port in ingress_port_list
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  # Bloque dinámico para ingress rules
  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      description = "Allow traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
      
    }
    
  }

  tags = {
    Name = "Public Instance SG-${local.suffix}"
  }
}

# versión antigua de ingress rule sin dynamic block (bloque dinámico).
/*

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  tags = {
    Name = "Public Instance SG-${local.suffix}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  description = "SSH over Internet"
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Nuevo ingress rule para HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  description = "HTTP over Internet"
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Nuevo ingress rule para HTTPS
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  description = "HTTPS over Internet"
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
*/

/*resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  description = "SSH over Internet"
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv6         = aws_vpc.vpc_virginia.ipv6_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}*/

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

module "myBucket" {
  source = "./modulos/s3"
  bucket_name = "nombre-unico-12345678910"
}

output "s3_arn" {
  value = module.myBucket.s3_bucket_arn
}

# module "terraform_state_backend_aws_example" {
#   source = "cloudposse/tfstate-backend/aws"
#   version     = "1.5.0"
#   namespace  = "example_test"
#   stage      = "prod"
#   name       = "terraform"
#   attributes = ["state"]

#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"
#   force_destroy                      = false
# }