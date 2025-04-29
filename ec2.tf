resource "aws_instance" "web" {
  ami           = "ami-0b4f379183e5706b9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "HelloWorldTerraform"
  }


 provisioner "local-exec" {
   
   command = "echo  ${self.private_ip} > inventory" #self = aws_instance.web
 
 }

 connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }


  provisioner "remote-exec" {
    inline = [
      "echo 'this is from remote-exec'> /tmp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      
    ]
  }
}


 resource "aws_security_group" "web" {
  name        = "provisoners"
  description = "Allow to connect from laptop"
    ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
 }

   ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
 }
    
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }



  tags = {
    Name = "provisoners"
  }
}
