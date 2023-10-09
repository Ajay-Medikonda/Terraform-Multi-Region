resource "aws_vpc" "default-1" {
  provider             = aws.east-1
  cidr_block           = element(var.vpc_cidr, 0)
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name              = element(var.vpc_name, 0)
    Owner             = "Ajay Medikonda"
    environment       = local.environment
    Terraform-Managed = "Yes"
    ProjectID         = local.projid
  }
}

resource "aws_vpc" "default-2" {
  provider             = aws.east-1
  cidr_block           = element(var.vpc_cidr, 1)
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name              = element(var.vpc_name, 1)
    Owner             = "Ajay Medikonda"
    environment       = local.environment
    Terraform-Managed = "Yes"
    ProjectID         = local.projid
  }
}

resource "aws_vpc" "default-3" {
  provider             = aws.east-2
  cidr_block           = element(var.vpc_cidr, 2)
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name              = element(var.vpc_name, 2)
    Owner             = "Ajay Medikonda"
    environment       = local.environment
    Terraform-Managed = "Yes"
    ProjectID         = local.projid
  }
}