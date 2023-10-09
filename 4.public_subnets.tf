resource "aws_subnet" "public-subnets1" {
  provider          = aws.east-1
  vpc_id            = aws_vpc.default-1.id
  cidr_block        = element(var.public_subnet_cidrs, 0)
  availability_zone = element(var.azs, 0)
  tags = {
    Name              = "${element(var.vpc_name, 0)}-PublicSubnet-1"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}
resource "aws_subnet" "public-subnets2" {
  provider          = aws.east-1
  vpc_id            = aws_vpc.default-2.id
  cidr_block        = element(var.public_subnet_cidrs, 1)
  availability_zone = element(var.azs, 1)
  tags = {
    Name              = "${element(var.vpc_name, 1)}-PublicSubnet-2"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}
resource "aws_subnet" "public-subnets3" {
  provider          = aws.east-2
  vpc_id            = aws_vpc.default-3.id
  cidr_block        = element(var.public_subnet_cidrs, 2)
  availability_zone = element(var.azs, 2)
  tags = {
    Name              = "${element(var.vpc_name, 2)}-PublicSubnet-3"
    Terraform-Managed = "Yes"
    Env               = local.environment
    ProjectID         = local.projid
  }
}