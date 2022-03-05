provider "aws" {

  region     = "us-west-2"

  access_key = "AKIAZ2IEVQO5WSZ3M54U"  

  secret_key = "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"

}


resource "aws_instance" "app_server" {

  ami             = "ami-0892d3c7ee96c0bf7"

  instance_type   = "t2.micro"


  key_name        = "aws-key"

  tags  = {

    "Name"      = "Jenkins"

      }

 

 

connection {

    type         = "ssh"

    host         = self.public_ip

    user         = "ubuntu"

   private_key = file("/home/guptadinesh35gm/aws-key/aws-key.pem")

   }

 

provisioner "remote-exec"  {

    inline  = [



     "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",

      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",

      "sudo apt-get update -qq",

      "sudo apt-get install software-properties-common -y",

      "sudo add-apt-repository ppa:deadsnakes/ppa -y",

      "sudo apt-get install -y python",

      "sudo apt-get install -y openjdk-11-jdk",

      "sudo apt-get install jenkins -y",

      "JAVA_HOME=/usr/lib/jvm/openjdk-11",

      "PATH=$PATH:$JAVA_HOME/bin",

      "export PATH",

      "sudo systemctl start jenkins",













      ]

   }

   

 }



 resource "aws_key_pair" "deployer" {






  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPf7X8Hpd2BLBhuq/PEEHURiHPSLHQ5XVeVM9Qj0u2CIYhee7cp1R77hLEE3a3hr6RTRgz1K2hdlRk7Kl/b3PNwIiBda62HvRniZOXIhZLw7NYl7Rt7Uz+gjf0tC4lGQISWrJngca77xeGxOMM69H7BjZDieLS5OGViXXupMUM4fQanz+eefTKAr/L8eFVRP0r2deGEqxp8JKnuSpu5PYtIpSMOJdJxxsjgUTc/Oq0xI2lVk+Fff9HHU7f9wnxVPaxs62zekZMWpD3dU6UUsch3DZ48jxvSuGpWkZS1BQeuJoKNIOu/8XlBUg07D6mZf7XBm/uqJTqHNXZh9+s1ZML guptadinesh35gm@ip-172-31-18-202"



}