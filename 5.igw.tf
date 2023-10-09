resource "aws_internet_gateway" "default-1" {
  provider = aws.east-1
  vpc_id   = aws_vpc.default-1.id
  tags = {
    Name              = "${element(var.vpc_name, 0)}-IGW"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}

resource "aws_internet_gateway" "default-2" {
  provider = aws.east-1
  vpc_id   = aws_vpc.default-2.id
  tags = {
    Name              = "${element(var.vpc_name, 1)}-IGW"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}

resource "aws_internet_gateway" "default-3" {
  provider = aws.east-2
  vpc_id   = aws_vpc.default-3.id
  tags = {
    Name              = "${element(var.vpc_name, 2)}-IGW"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}