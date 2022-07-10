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
  ami_name                     = "aws-dlami-autots-reworked"
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
      "sudo chmod u+x /home/ubuntu/iot/experiments/setup_environment.sh",
      "sudo bash /home/ubuntu/iot/experiments/setup_environment.sh",
      "export PATH=\"/home/ubuntu/.local/bin:$PATH\"",
      "python3 -m pip install --user pipenv",
      "pipenv install -v"
    ]
  }

}



