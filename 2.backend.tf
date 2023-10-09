terraform {
  backend "s3" {
    bucket         = "ajay-terraform-bucket"
    key            = "ansible.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ajay-terraform-state-lock"
    encrypt        = true
  }
}