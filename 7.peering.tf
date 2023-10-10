#vpc peering with in the region
resource "aws_vpc_peering_connection" "VPC_Peering_1_2" {
  provider      = aws.east-1
  peer_owner_id = var.peer_owner_id
  vpc_id        = aws_vpc.default-1.id
  peer_vpc_id   = aws_vpc.default-2.id
  auto_accept   = true
  #Note : If both the vpc's are in same region then no need to "peer_region = "us-east-" 
  #       and if "peer_region" not mentioned then we can give "auto_accept = true" (wishlist)
  #       directly here it self & no need to provide "aws_vpc_peering_connection_accepter"
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

resource "aws_route" "aws_vpc_default-1-2" {
  provider                  = aws.east-1
  route_table_id            = aws_route_table.terraform-public1.id
  destination_cidr_block    = "192.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_2.id
}

resource "aws_route" "aws_vpc_default-2-1" {
  provider                  = aws.east-1
  route_table_id            = aws_route_table.terraform-public2.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_2.id
}

################################################################################

#vpc peering with Cross region
# Requester's side of the connection.
resource "aws_vpc_peering_connection" "VPC_Peering_1_3" {
  provider = aws.east-1

  vpc_id        = aws_vpc.default-1.id
  peer_vpc_id   = aws_vpc.default-3.id
  peer_region   = "us-east-2"
  peer_owner_id = var.peer_owner_id
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "VPC_Peering_1_3" {
  provider = aws.east-2

  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id
  auto_accept               = true

  tags = {
    Name = "VPC Peering between vpc.default-1 and vpc.default-3"
    Side = "Accepter"
  }
}

resource "aws_vpc_peering_connection_options" "requester1" {
  provider = aws.east-1

  # As options can't be set until the connection has been accepted
  # create an explicit dependency on the accepter.
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.VPC_Peering_1_3.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  depends_on = [aws_vpc_peering_connection_accepter.VPC_Peering_1_3]
}

resource "aws_vpc_peering_connection_options" "accepter1" {
  provider = aws.east-2

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.VPC_Peering_1_3.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "aws_vpc_default-1-3" {
  provider                  = aws.east-1
  route_table_id            = aws_route_table.terraform-public1.id
  destination_cidr_block    = "172.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id
}

resource "aws_route" "aws_vpc_default-3-1" {
  provider                  = aws.east-2
  route_table_id            = aws_route_table.terraform-public3.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id
}

################################################################################

#vpc peering with Cross region
# Requester's side of the connection.

resource "aws_vpc_peering_connection" "VPC_Peering_2_3" {
  provider = aws.east-1

  vpc_id        = aws_vpc.default-2.id
  peer_vpc_id   = aws_vpc.default-3.id
  peer_region   = "us-east-2"
  peer_owner_id = var.peer_owner_id
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "VPC_Peering_2_3" {
  provider = aws.east-2

  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_2_3.id
  auto_accept               = true

  tags = {
    Name = "VPC Peering between vpc.default-2 and vpc.default-3"
    Side = "Accepter"
  }
}

resource "aws_vpc_peering_connection_options" "requester2" {
  provider = aws.east-1

  # As options can't be set until the connection has been accepted
  # create an explicit dependency on the accepter.
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.VPC_Peering_2_3.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  depends_on = [aws_vpc_peering_connection_accepter.VPC_Peering_2_3]
}

resource "aws_vpc_peering_connection_options" "accepte2" {
  provider = aws.east-2

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.VPC_Peering_2_3.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "aws_vpc_default-2-3" {
  provider                  = aws.east-1
  route_table_id            = aws_route_table.terraform-public2.id
  destination_cidr_block    = "172.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_2_3.id
}

resource "aws_route" "aws_vpc_default-3-2" {
  provider                  = aws.east-2
  route_table_id            = aws_route_table.terraform-public3.id
  destination_cidr_block    = "192.0.1.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_2_3.id
}