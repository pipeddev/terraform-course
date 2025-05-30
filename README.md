LINK repositorio: https://github.com/terraformdpac/practica-terraform
terraform registry: https://registry.terraform.io/

### Commands

- terraform plan --out s3.plan
- terraform apply s3.plan
- terraform fmt // ordenar formato
- terraform validate // validar el archivo.
- alias // crear alias para ser utilizadas
- terraform plan -var ohio_cidr="10.20.0.0/16" // asignar variable por commando
- terraform output
- terraform output linux_public_ip
- terraform apply --auto-approve=true // no pide confirmación
- terraform apply --target <target> // ejemplo: aws_subnet.public_subnet
- terraform show -json // muestra los recursos deployados. -json es opcional.
- terraform providers // lista los proveedores que estamos trabajando y si tienen alguna constraints.
- terraform refresh // va a revisar cambios en la infra desplegada, en caso de encontrar cambios los aplica en el archivo `.state`. ej: modifiqué un tag en e aws console realicé el refresh y el state cambio.
- terraform graph // muestra una lista de dependencias y como se interrelacionan los recursos desplegados.
- terraform graph | dot -Tsvg > graph.svg // para generar un grafico.
- terraform state list // lista los recursos desplegados.
- terraform state show <nombre recurso> // - ver todo el detalle de un recurso ejemplo: terraform state show aws_instance.public_instance
- terraform state mv // sirve para mover recursos dentro de nuestro terraform state.
- terraform state rm // para eliminar recursos en el terraform.state NO recursos desplegados. ej: terraform state rm aws_instance.public_instance
- terraform --replace=<nombre recurso> // reemplaza el recurso especificado durante la siguiente ejecución de `apply`, forzando su recreación.

### Conceptos

- trabajar con un tfstate remoto permite el trabajo en equipo, protección del tfstate, control de concurrencia, cifrado, confidencialidad y backups.

- provisioners: nos permiten ejecutar codigo de manera local o de manera remota en una instancia que estamos creando.
