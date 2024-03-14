resource "aws_vpc" "main" {
cidr_block = "10.0.0.0/16"
 
tags = {
   Name = "SM VPC"
}
}
 
 
resource "aws_subnet" "public_subnets" {
#count      = length(var.public_subnet_cidrs)
vpc_id     = aws_vpc.main.id
cidr_block = var.public_subnet_cidrs
availability_zone = var.azs
tags = {
   Name = "Public Subnet"
}
}
 
resource "aws_subnet" "private_subnets" {
#count      = length(var.private_subnet_cidrs)
vpc_id     = aws_vpc.main.id
cidr_block = var.private_subnet_cidrs
availability_zone = var.azs
tags = {
   Name = "Private Subnet"
}
}
 
 
resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.main.id
 
tags = {
   Name = "Project VPC IG"
}
}
 
resource "aws_route_table" "second_rt" {
vpc_id = aws_vpc.main.id
 
route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
}
 
tags = {
   Name = "2nd Route Table"
}
}
resource "aws_route_table_association" "public_subnet_asso" {
#count = length(var.public_subnet_cidrs)
subnet_id      = aws_subnet.public_subnets.id
route_table_id = aws_route_table.second_rt.id
}
 
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.main.id}"
 
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}
 
 
 
resource "aws_instance" "demoinstance" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
#  key_name = aws_key_pair.tests.public_key
  vpc_security_group_ids = [ aws_security_group.ssh-allowed.id ]
  subnet_id = aws_subnet.public_subnets.id
  associate_public_ip_address = true
  tags = {
    Name = "My Public Instance"
  }
}
