# Use AWS Terraform provider
variable "accessKey" {
  type        = "string"
  description = "AWS access key id"
  default = "missing"
}

variable "secretKey" {
  type        = "string"
  description = "AWS access secret key"
  default = "missing"
}

provider "aws" {
  access_key = "${var.accessKey}"
  secret_key = "${var.secretKey}"
  region     = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0520e698dd500b1d1"
  instance_type = "t2.micro"
}
