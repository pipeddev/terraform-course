#ami-0f88e80871fd81e91
resource "aws_instance" "public_instance" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  lifecycle {
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
  }
}