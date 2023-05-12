resource "aws_eip" "eip_for_nat_gateway_private_subnet1" {
  vpc    = "true"

  tags   = {
    Name = "nate_nat_gateway_private_subnet1_eip"
  }
}


resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_private_subnet1.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags   = {
    Name = "nate-gateway-private_subnet"
  }

  
  depends_on = [aws_internet_gateway.igw]
}



resource "aws_route_table" "private_route_table_az1" {
  vpc_id            = aws_vpc.my-vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az1.id
  }

  tags   = {
    Name = "private-routetable-az1"
  }
}

resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
  subnet_id         = aws_subnet.private_subnet1.id
  route_table_id    = aws_route_table.private_route_table_az1.id
}




