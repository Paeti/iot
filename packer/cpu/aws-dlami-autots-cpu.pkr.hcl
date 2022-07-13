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


source "amazon-ebs" "ubuntu-22-04" {
  ami_name                     = "aws-dlami-autots-cpu"
  instance_type                = "m5.8xlarge"
  region                       = "eu-central-1"
  source_ami                   = "ami-065deacbcaac64cf2"
  ssh_username                 = "ubuntu"
  communicator                 = "ssh"
  ssh_disable_agent_forwarding = false
}

build {
  name = "SetupEnv"
  sources = [
    "source.amazon-ebs.ubuntu-22-04"
  ]

  provisioner "file" {
    source      = "/home/paettfish/.ssh/known_hosts"
    destination = "/home/ubuntu/.ssh/known_hosts"
  }

  provisioner "shell" {
    inline = [
      "git clone git@github.com:Paeti/iot.git",
      "cd /home/ubuntu/iot/experiments",
      "sudo chmod u+x /home/ubuntu/iot/experiments/setup_environment_cpu.sh",
      "sudo bash /home/ubuntu/iot/experiments/setup_environment_cpu.sh",
      "export PATH=\"/home/ubuntu/.local/bin:$PATH\"",
      "python3 -m pip install --user pipenv",
      "export TMPDIR=/home/ubuntu/",
      "pipenv install -v"
    ]
  }

}



