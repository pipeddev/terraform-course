# #ami-0f88e80871fd81e91

variable "instancias" {
  description = "Nombre de instancias"
  #type = list(string) sirve para ser usado con count o hacer un parse en la instancia.
  type = set(string)
  default = [  "mysql", "jumpserver" ]
}
resource "aws_instance" "public_instance" {
  #count         = length(var.instancias)
  for_each      = var.instancias # si fuese lista podemos parsear con toset(var.instancias)
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = file("scripts/userdata.sh") # Archivo de script de usuario para inicialización

  tags = {
    "Name" = each.value
  }
}


# Estructuras condicionales para crear una instancia.
resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring == 1 ? 1 : 0 # Condicional para crear la instancia de monitoreo
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = file("scripts/userdata.sh") # Archivo de script de usuario para inicialización

  tags = {
    "Name" = "Monitoreo"
  }
}