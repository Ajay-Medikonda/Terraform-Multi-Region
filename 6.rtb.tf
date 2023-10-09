resource "aws_route_table" "terraform-public1" {
  provider = aws.east-1
  vpc_id   = aws_vpc.default-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-1.id
  }
  tags = {
    Name = element(var.Public_Routing_Table, 0)
  }
}

resource "aws_route_table_association" "terraform-public1" {
  provider       = aws.east-1
  subnet_id      = aws_subnet.public-subnets1.id
  route_table_id = aws_route_table.terraform-public1.id
}

resource "aws_route_table" "terraform-public2" {
  provider = aws.east-1
  vpc_id   = aws_vpc.default-2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-2.id
  }
  tags = {
    Name = element(var.Public_Routing_Table, 1)
  }
}

resource "aws_route_table_association" "terraform-public2" {
  provider       = aws.east-1
  subnet_id      = aws_subnet.public-subnets2.id
  route_table_id = aws_route_table.terraform-public2.id
}

resource "aws_route_table" "terraform-public3" {
  provider = aws.east-2
  vpc_id   = aws_vpc.default-3.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-3.id
  }
  tags = {
    Name = element(var.Public_Routing_Table, 2)
  }
}

resource "aws_route_table_association" "terraform-public3" {
  provider       = aws.east-2
  subnet_id      = aws_subnet.public-subnets3.id
  route_table_id = aws_route_table.terraform-public3.id
}