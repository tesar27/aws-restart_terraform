resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1d0"  # Amazon Linux 2 in us-west-2; update if needed
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true
  tags = {
    Name = "cli-host"
  }
}