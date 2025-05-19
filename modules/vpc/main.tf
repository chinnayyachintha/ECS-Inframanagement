# Create the main VPC with specified CIDR block and instance tenancy
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    { Name = "PropStream-VPC" }
  )
}


# Create public subnets from the var.public_subnets map
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets                         # Create one subnet per map entry

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value                  # CIDR block for each public subnet
  map_public_ip_on_launch = true                         # Automatically assign public IP to instances

  tags = merge(
    var.common_tags,
    { Name = each.key }                                 # Use map key as subnet name
  )
}

# Create private subnets from the var.private_subnets map
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = merge(
    var.common_tags,
    { Name = each.key }
  )
}

# Create an Internet Gateway (IGW) and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    { Name = "PropStream-IGW" }
  )
}

# Allocate an Elastic IP (EIP) for the NAT Gateway
resource "aws_eip" "nat_eip" {

  tags = merge(
    var.common_tags,
    { Name = "PropStream-NAT-EIP" }
  )
}

# Create a NAT Gateway in the first public subnet and associate the EIP
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id                   # Elastic IP allocated above
  subnet_id     = element(values(aws_subnet.public_subnets)[*].id, 0)  # Place NAT Gateway in first public subnet

  tags = merge(
    var.common_tags,
    { Name = "PropStream-NAT-GW" }
  )

  depends_on = [aws_internet_gateway.igw]             # NAT Gateway depends on IGW being created
}

# Create the public route table for routing traffic from public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    { Name = "Public Route Table" }
  )
}

# Create the private route table for routing traffic from private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    { Name = "Private Route Table" }
  )
}

# Create a route in the public route table to send outbound internet traffic to the IGW
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"                   # All IPv4 traffic
  gateway_id             = aws_internet_gateway.igw.id   # Send traffic to Internet Gateway
}

# Create a route in the private route table to send outbound internet traffic to the NAT Gateway
resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"                   # All IPv4 traffic
  nat_gateway_id         = aws_nat_gateway.nat_gw.id     # Send traffic through NAT Gateway
}

# Associate all public subnets with the public route table
resource "aws_route_table_association" "public_associations" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate all private subnets with the private route table
resource "aws_route_table_association" "private_associations" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
