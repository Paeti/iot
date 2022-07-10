packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "select-profile" {
  profile = "rosetta-hub"
  region  = "eu-west-1"
}


source "amazon-ebs" "ubuntu-dlami" {
  ami_name                     = "aws-dlami-autots"
  instance_type                = "p3.2xlarge"
  region                       = "eu-west-1"
  source_ami                   = "ami-0cd454db24da5cb9b"
  ssh_username                 = "ubuntu"
  communicator                 = "ssh"
  ssh_disable_agent_forwarding = false
}

build {
  name = "SetupEnv"
  sources = [
    "source.amazon-ebs.ubuntu-dlami"
  ]

  provisioner "file" {
    source      = "/home/paettfish/.ssh/known_hosts"
    destination = "/home/ubuntu/.ssh/known_hosts"
  }

  provisioner "shell" {
    inline = [
      "git clone git@github.com:Paeti/iot.git",
      "cd /home/ubuntu/iot/experiments",
      "touch i_was_here.txt",
      "source ./setup_environment.sh >> log.txt",
    ]
  }

}



