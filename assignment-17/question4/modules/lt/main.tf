resource "aws_launch_template" "lt1" {
  image_id = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  name = "lt_1"
  vpc_security_group_ids = [ var.sgid ]
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install apache2* -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "Hi i am $HOSTNAME" >> /var/www/html/index.html    
    EOF
  )
}
