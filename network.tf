#-----Network.tf--------
resource "aws_subnet" "TF_public_subnet" {
    count = var.public_sn_count
    vpc_id = aws_vpc.default.id
    cidr_block = var.public_cidrs[count.index]
    map_public_ip_on_launch = true
   # availability_zone = 
    
    tags = {
        Name = "TF_public_${count.index + 1}"
    }
}

resource "aws_route_table_association" "TF_public_associated" {
    count = var.public_sn_count
    subnet_id = aws_subnet.TF_public_subnet.*.id[count.index]
    route_table_id = aws_route_table.TF_public_rt.id
}

#define internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "TF_public_rt" {
    vpc_id = aws_vpc.default.id
    
    tags = {
        Name = "TF_public"
    }
}

resource "aws_route" "default_route" {
    route_table_id = aws_route_table.TF_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_default_route_table" "TF-private_rt" {
    default_route_table_id = aws_vpc.default.default_route_table_id
    
    tags = {
        Name = "TF_private"
    }
}