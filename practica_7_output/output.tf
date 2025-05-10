output "linux_public_ip" {
  value = aws_instance.linux.public_ip
  description = "Muestro la IP publica asignada a la instancia"
}