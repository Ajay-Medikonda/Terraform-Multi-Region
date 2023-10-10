resource "aws_vpc_peering_connection" "VPC_Peering_1_2" {
  #provider          = aws.east-1  
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.default-1.id
  vpc_id        = aws_vpc.default-2.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering between vpc.default-1 and vpc.default-2"
  }
}

resource "aws_route" "aws_vpc_default-1" {
  #provider          = aws.east-1
  route_table_id            = aws_route_table.terraform-public1.id
  destination_cidr_block    = "192.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_2.id
  #depends_on                = [aws_route_table.terraform-public]
  #cidr_block = "10.0.0.0/16"
}

resource "aws_route" "aws_vpc_default-2" {
  #provider          = aws.east-1
  route_table_id            = aws_route_table.terraform-public2.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_2.id
  #depends_on                = [aws_route_table.terraform-public]
  #cidr_block = "192.0.0.0/16"
}