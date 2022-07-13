provider "aws" {
  region  = "eu-central-1"
  profile = "default"
}



resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "key-${uuid()}"
  public_key = "${tls_private_key.key.public_key_openssh}"
}

resource "local_file" "pem" {
  filename        = "${aws_key_pair.generated_key.key_name}.pem"
  content         = "${tls_private_key.key.private_key_pem}"
  file_permission = "400"
}

resource "aws_security_group" "jupyter" {
  name        = "${var.service}-${uuid()}"
  description = "Security group for ${title(var.service)}"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  
  ingress {
    from_port   = 8888
    to_port     = 8898
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "${title(var.service)}"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Contact     = "${var.contact}"
    Environment = "${title(var.environment)}"
    Name        = "${var.service}-${uuid()}"
    Service     = "${title(var.service)}"
    Terraform   = "true"
  }
  
}

resource "aws_instance" "jupyter" {
  ami                    = "${var.ami}"
  availability_zone      = "${var.availability_zone}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.generated_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jupyter.id}"]
  tags = {
    Name        = "${title(var.service)}-${timestamp()}"
    Service     = "${title(var.service)}"
    Contact     = "${var.contact}"
    Environment = "${title(lower(var.environment))}"
    Terraform   = "true"
  }

  root_block_device {
    volume_size           = "60"
    volume_type           = "gp2"
  }
  
  volume_tags = {
    Name        = "${title(var.service)}-${timestamp()}_ROOT"
    Service     = "${title(var.service)}"
    Contact     = "${var.contact}"
    Environment = "${title(lower(var.environment))}"
    Terraform   = "true"
  }
  
}

terraform {
  backend "local" {
  }
  
}
