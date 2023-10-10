#vpc peering with in the region
resource "aws_vpc_peering_connection" "VPC_Peering_1_2" {
  provider      = aws.east-1
  peer_owner_id = var.peer_owner_id
  vpc_id        = aws_vpc.default-1.id
  peer_vpc_id   = aws_vpc.default-2.id
  auto_accept = true 
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
resource "aws_vpc_peering_connection" "VPC_Peering_1_3" {
  provider      = aws.east-1
  peer_owner_id = var.peer_owner_id
  vpc_id        = aws_vpc.default-1.id
  peer_vpc_id   = aws_vpc.default-3.id
  peer_region = "us-east-2"
  auto_accept               = false

  #Note : If both the vpc's are in different region then we need  "peer_region = "us-east-" 
  #       and if "peer_region"  mentioned then we can't give "auto_accept = true" (wishlist)
  #       directly here it self & we need to provide "aws_vpc_peering_connection_accepter" seperately

  tags = {
    Name = "VPC Peering between vpc.default-1 and vpc.default-3"
  }
}

resource "aws_vpc_peering_connection_accepter" "VPC1-3" {
  provider                  = aws.east-2
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection_options" "VPC1-3-r" {
  provider                  = aws.east-2
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [ aws_vpc_peering_connection_accepter.VPC1-3 ]

}

# resource "aws_vpc_peering_connection_options" "VPC1-3-a" {
#   # provider                  = aws.east-2
#   vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id

#   requester {
#     allow_remote_vpc_dns_resolution = true
#   }

#   # depends_on = [ aws_vpc_peering_connection_accepter.VPC1-3 ]
# }



resource "aws_route" "aws_vpc_default-1-3" {
  provider                  = aws.east-1
  route_table_id            = aws_route_table.terraform-public1.id
  destination_cidr_block    = "172.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_1_3.id
}

# resource "aws_vpc_peering_connection" "VPC_Peering_3_1" {
#   provider      = aws.east-2
#   peer_owner_id = var.peer_owner_id
#   vpc_id        = aws_vpc.default-3.id
#   peer_vpc_id   = aws_vpc.default-1.id
#   peer_region = "us-east-1"
#   #Note : If both the vpc's are in different region then we need  "peer_region = "us-east-" 
#   #       and if "peer_region"  mentioned then we can't give "auto_accept = true" (wishlist)
#   #       directly here it self & we need to provide "aws_vpc_peering_connection_accepter" seperately

#   tags = {
#     Name = "VPC Peering between vpc.default-3 and vpc.default-1"
#   }
# }

# resource "aws_vpc_peering_connection_accepter" "VPC3-1" {
#   provider                  = aws.east-1
#   vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_3_1.id
#   auto_accept               = true
  
#   accepter {
#     allow_remote_vpc_dns_resolution = true
#   }

#   requester {
#     allow_remote_vpc_dns_resolution = true
#   }
# }

# resource "aws_route" "aws_vpc_default-3-1" {
#   provider                  = aws.east-2
#   route_table_id            = aws_route_table.terraform-public3.id
#   destination_cidr_block    = "10.0.0.0/16"
#   vpc_peering_connection_id = aws_vpc_peering_connection.VPC_Peering_3_1.id
# }