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
