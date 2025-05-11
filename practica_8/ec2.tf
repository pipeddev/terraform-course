#ami-0f88e80871fd81e91
resource "aws_instance" "public_instance" {
  ami           = "ami-0f88e80871fd81e91"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
}