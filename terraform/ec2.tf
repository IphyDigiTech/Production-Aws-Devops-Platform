resource "aws_instance" "blue" {
  ami           = "ami-0c398cb65a93047f2"
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name        = "production-blue-server"
    Environment = "blue"
  }
}

resource "aws_instance" "green" {
  ami           = "ami-0c398cb65a93047f2"
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public_2.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name        = "production-green-server"
    Environment = "green"
  }
}

resource "aws_lb_target_group_attachment" "blue" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.blue.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green.id
  port             = 80
}