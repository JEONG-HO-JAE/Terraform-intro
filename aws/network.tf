resource "aws_vpc" "hojae_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "hojae-vpc"
  }
}

resource "aws_internet_gateway" "hojae_gw" {
  vpc_id = aws_vpc.hojae_vpc.id

  tags = {
    Name = "hojae-gw"
  }
}

resource "aws_route_table_association" "hojae_associat" {
  subnet_id      = aws_subnet.hojae_subnet.id
  route_table_id = aws_route_table.hojae_rt.id
}

resource "aws_route_table" "hojae_rt" {
  vpc_id = aws_vpc.hojae_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hojae_gw.id
  }


  tags = {
    Name = "hojae-rt"
  }
}


resource "aws_subnet" "hojae_subnet" {
  vpc_id            = aws_vpc.hojae_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "hojae-subnet"
  }
}


resource "aws_network_interface" "hojae_ni" {
  subnet_id   = aws_subnet.hojae_subnet.id

  attachment {
    instance     = aws_instance.FirstInstance.id
    device_index = 1
  }
   attachment {
         instance     = aws_instance.SecondInstance.id
         device_index = 1
       }


  tags = {
    Name = "hojae_network_interface1"
  }
}



resource "aws_security_group" "hojae_sg" {
  vpc_id       = aws_vpc.hojae_vpc.id
  name         = "hojae-sg"
  description  = "My VPC Security Group"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
        from_port = 5985
        to_port   = 5985
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
        from_port = 5986
        to_port  = 5986
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


