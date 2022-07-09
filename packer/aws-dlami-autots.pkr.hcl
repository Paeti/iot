packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "select-profile" {
  profile = "default"
  region  = "eu-central-1"
}


source "amazon-ebs" "ubuntu-dlami" {
  ami_name                     = "aws-dlami-autots"
  instance_type                = "p3.2xlarge"
  region                       = "eu-central-1"
  source_ami                   = "ami-0f6529b0e4b7ddfdb"
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
      "git config --global user.email \"patrick.reckeweg@googlemail.com\"",
      "git clone git@github.com:Paeti/iot.git",
      "cd iot/experiments",
      ". ./setup_environment.sh",
    ]
  }

}



