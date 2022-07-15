variable "availability_zone" {
  default = "eu-central-1c"
}

variable "contact" {
  default = "blake.cannon@caprinomics.com"
}

variable "environment" {
  default = "TEST"
}

variable "instance_type" {
  default = "m5.4xlarge"
}

variable "service" {
  default = "jupyter"
}

variable "ami" {
  default = "ami-05a17b57c51529c38" 
}
