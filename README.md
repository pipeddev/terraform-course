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
- terraform --replace=<resource_type>.<resource_name> // reemplaza el recurso especificado durante la siguiente ejecución de `apply`, forzando su recreación.
- terraform taint <resource_type>.<resource_name> // El comando terraform taint se utiliza para marcar un recurso como "estropeado" o dañado, lo que indica a Terraform que ese recurso debe ser destruido y recreado en la próxima ejecución de terraform apply.
- terraform untaint <resource_type>.<resource_name> // para desmarcar
- export TF_LOG_PATH=logs.txt // genera los logs en un archivo.
- export TF_LOG=TRACE|INFO|WARNING // india el tipo de logs
- terraform import <resource_type>.<resource_name> <id_instance> = terraform import aws_instance.mywebserver i-0ecead067079c2571 // el import trae el recurso y su información en el terraform state, no modifica el archivo, pero si quieres ver la información que trajo puedes hacer con este comando: terraform state show aws_instance.mywebserver
- Los workspace interface nos permiten reutilizar nuestro código para desplegarlo en diferentes ambiente development o production. sin embargo, no es una opción muy popular.
- terraform workspace list
- terraform workspace new <name> // para crear un nuevo workspace
- terraform workspace select <name> = terraform workspace select default // para cambiar de workspace
- terraform workspace delete <name> // elimina el workspace.
- terraform workspace select <name> // cambiar el workspace

### Conceptos

- trabajar con un tfstate remoto permite el trabajo en equipo, protección del tfstate, control de concurrencia, cifrado, confidencialidad y backups.

- provisioners: nos permiten ejecutar codigo de manera local o de manera remota en una instancia que estamos creando.
