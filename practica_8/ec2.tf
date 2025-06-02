# #ami-0f88e80871fd81e91
resource "aws_instance" "public_instance" {
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = file("scripts/userdata.sh") # Archivo de script de usuario para inicialización

 # este codigo lo ejecuta el usuario root no el usuario ec2-user.
  # user_data se ejecuta una vez al iniciar la instancia por primera vez.
  # user_data = <<EOF
  #   #!/bin/bash
  #   echo "Este es un mensaje" > ~/mensaje.txt
  # EOF
 
  
  # provisioner se crean dentro de la instancia.
  
  # Local-exec se ejecuta en la máquina local donde se ejecuta Terraform.
  provisioner "local-exec" {
    command = "echo instance created with IP: ${aws_instance.public_instance.public_ip} >> datos_instancia.txt"
  }

   provisioner "local-exec" {
    when = "destroy"
    command = "echo instance ${self.public_ip} destroyed >> datos_instancia.txt"
  }

  # Remote-exec se ejecuta dentro de la instancia.
  # provisioner "remote-exec" {
  #   inline = [ 
  #     "echo 'Hello, World!' > ~/saludo.txt"
  #   ]
    
  #   connection {
  #     type = "ssh"
  #     host = self.public_ip
  #     user = "ec2-user"
  #     private_key = file("terraform-key.pem") # Asegúrate de que la ruta al archivo de clave privada sea correcta
  #   }
  # }



  # lifecycle {
    /* Esto indica que, si Terraform necesita reemplazar el recurso (por ejemplo, por un cambio en una propiedad inmutable), 
                          primero creará el nuevo recurso y solo después destruirá el antiguo. Así se evita tiempo de inactividad.*/
    #create_before_destroy = true 
    /* Esto evita que el recurso sea destruido por accidente. Si intentas destruirlo (por ejemplo, con terraform destroy), 
                Terraform lanzará un error y no permitirá la destrucción del recurso.*/
    #prevent_destroy = true 
    /* Esto indica que Terraform ignorará los cambios en las propiedades especificadas. 
                Esto puede ser útil si sabes que un recurso va a cambiar fuera de Terraform y no quieres que eso cause un cambio en tu infraestructura. */
    #ignore_changes = [ ] 

    /* Esto indica que Terraform no debe intentar reemplazar el recurso si se producen cambios en las propiedades especificadas. 
      Esto puede ser útil si sabes que un recurso va a cambiar fuera de Terraform y no quieres que eso cause un cambio en tu infraestructura. */
    #replace_triggered_by = [  ]
  # }
}


# este recurso fue rescatado de un ejemplo donde aplicamos terraform import
# terraform import aws_instance.mywebserver i-0c1234567890abcdef
# el archivo no se modifica, pero al ejecutar el comando terraform state show aws_instance.mywebserver
# se muestra la configuración del recurso importado.


# resource "aws_instance" "mywebserver" {
#   ami                                  = "ami-0953476d60561c955"
#   instance_type                        = "t2.micro"
#   key_name                             = data.aws_key_pair.key.key_name
#   subnet_id                            = aws_subnet.public_subnet.id
#   tags                                 = {
#       "Name" = "MyServer"
#   }
 
#   vpc_security_group_ids               = [
#       aws_security_group.sg_public_instance.id,
#   ]
# }