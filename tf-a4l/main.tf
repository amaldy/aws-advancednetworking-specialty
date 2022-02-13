/* 
This is the vpc script for my aws account for training with learn.cantrill.io
*/

//1. Create the VPC
resource "aws_vpc" "a4l-vpc1" {

  cidr_block       = "10.16.0.0/16"
  instance_tenancy = "default" //this is the default, if we use dedicated it will cost. 

  //with the below option, this means that amazon will provide the ipv6 address and will be a /56. We will have to subnet it out to a 64. ex. 
  // aws gave me 2600:1f18:1b2f:9700::/56 (us-east-1) so the 1st sub would be 64 and give 4,091 addresses. 

  assign_generated_ipv6_cidr_block = true //this makes the vpc have ipv6 address space by aws
  enable_dns_hostnames             = true //enable DNS hostname to the VPC.
  tags = {                                //always put the tags on here.
    "Name" = "a4l-vpc1"
  }

}
/*
SUBNETS 0-48 - this is the section for all subnets.

This is for AZ A
subnets we are going to do a /20 which gives us 16 subnets
2^20 = 0 (0+16=16), 16 (16+16=32),32 (32+16=48), 48 (48+16=64) 64 will be for AZB - 0 is reserved as we are going to use it

*/
resource "aws_subnet" "a4l-vpc1-sub0a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.0.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9700::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1a" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-reserved-A"
  }
}

resource "aws_subnet" "a4l-vpc1-sub1a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.16.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9701::/64"
  assign_ipv6_address_on_creation = true         //auto-assign an ipv6 address when its created
  availability_zone               = "us-east-1a" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-db-A"
  }
}
resource "aws_subnet" "a4l-vpc1-sub2a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.32.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9702::/64"
  assign_ipv6_address_on_creation = true         //auto-assign an ipv6 address when its created
  availability_zone               = "us-east-1a" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-app-A"
  }
}
resource "aws_subnet" "a4l-vpc1-sub3a" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.48.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9703::/64"
  assign_ipv6_address_on_creation = true         //auto-assign an ipv6 address when its created
  availability_zone               = "us-east-1a" //I like the az zone but for here we will leave it default.
  map_public_ip_on_launch         = true
  tags = {
    Name = "sn-web-A"
  }
}

/*SUBNETS 64-112 - this is the section for all subnets in AZB

AZ-B 64 will be reserved for the future we will start at 64+16 = 80, 80+16 =96, 96+16 = 112 ,112 +16 = 128 this will be for AZ-C rsvp.
*/

resource "aws_subnet" "a4l-vpc1-sub0b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.64.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9704::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1b" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-reserved-B"
  }
}

resource "aws_subnet" "a4l-vpc1-sub1b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.80.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9705::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1b" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-db-B"
  }
}
resource "aws_subnet" "a4l-vpc1-sub2b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.96.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9706::/64"
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1b" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-app-B"
  }
}
resource "aws_subnet" "a4l-vpc1-sub3b" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.112.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9707::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone       = "us-east-1b" //I like the az zone but for here we will leave it default.
  map_public_ip_on_launch = true
  tags = {
    Name = "sn-web-B"
  }
}
/*
SUBNETS 128 -176 - this is the section for all subnets in AZC
 AZ-C 128 will be reserved for the future we will start at 128 + 16  = 144 this will be for AZ-C rsvp.
*/

resource "aws_subnet" "a4l-vpc1-sub0c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.128.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9708::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1c" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-reserved-C"
  }
}
resource "aws_subnet" "a4l-vpc1-sub1c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.144.0/20"
  ipv6_cidr_block                 = "2600:1f18:1b2f:9709::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  availability_zone = "us-east-1c" //I like the az zone but for here we will leave it default.
  tags = {
    Name = "sn-db-C"
  }
}
resource "aws_subnet" "a4l-vpc1-sub2c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.160.0/20"
  availability_zone               = "us-east-1c" //I like the az zone but for here we will leave it default.
  ipv6_cidr_block                 = "2600:1f18:1b2f:9710::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created

  tags = {
    Name = "sn-app-C"
  }
}
resource "aws_subnet" "a4l-vpc1-sub3c" {
  vpc_id                          = aws_vpc.a4l-vpc1.id
  cidr_block                      = "10.16.176.0/20"
  availability_zone               = "us-east-1c" //I like the az zone but for here we will leave it default.
  ipv6_cidr_block                 = "2600:1f18:1b2f:9711::/64"
  assign_ipv6_address_on_creation = true //auto-assign an ipv6 address when its created
  map_public_ip_on_launch         = true //auto-assing public ip addresses, we need an igw.
  tags = {
    Name = "sn-web-C"
  }
}
//End of Subnet

//Create an IGW

resource "aws_internet_gateway" "a4l-igw" {
  vpc_id = aws_vpc.a4l-vpc1.id
  tags = {
    Name = "a4l-igw"
  }
}

//create a Route Table for Web and associate the igw
resource "aws_route_table" "a4l-vpc1-rt-web" {
  vpc_id = aws_vpc.a4l-vpc1.id
  route {
    //cidr_block = aws_vpc.am-vpc-tf.cidr_block
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.a4l-igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.a4l-igw.id
  }
  tags = {
    Name = "a4l-vpc1-rt-web"
  }
}


resource "aws_route_table_association" "a4l-vpc1-rt-asc1" {
  subnet_id = aws_subnet.a4l-vpc1-sub3a.id


  route_table_id = aws_route_table.a4l-vpc1-rt-web.id
}

resource "aws_route_table_association" "a4l-vpc1-rt-asc2" {
  subnet_id = aws_subnet.a4l-vpc1-sub3b.id

  route_table_id = aws_route_table.a4l-vpc1-rt-web.id
}

resource "aws_route_table_association" "a4l-vpc1-rt-asc3" {
  subnet_id = aws_subnet.a4l-vpc1-sub3c.id

  route_table_id = aws_route_table.a4l-vpc1-rt-web.id
}


//testing the ec2 instance for bastion host.
// Create Ubuntu and install/enable httpd - Create an ec2 instance, NAT Gateway.
/* 
resource "aws_security_group" "a4l-vpc-sg" {
  name        = "allow_all_traffic"
  description = "Allow all Traffic"
  vpc_id      = aws_vpc.a4l-vpc1.id
  //wan
  ingress {
    cidr_blocks = ["0.0.0.0/0"] //this is my public ip when I vpn
    description = "all traffic"
    from_port   = 0
    to_port     = -1
    protocol    = "all"
    self        = false
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "all traffic"
    from_port   = 0
    to_port     = -1
    protocol    = "all"
    self        = false
  }
}



resource "aws_network_interface" "a4l-vpc01-nic1" {
  subnet_id = aws_subnet.a4l-vpc1-sub3a.id
  //private_ips = [""]
  //map_public_ip_on_launch = true
  security_groups = [aws_security_group.a4l-vpc-sg.id]
  tags = {
    Name = "a4l-bastion-1a-nic"
  }


}


resource "aws_instance" "a4l-ec2-web-pub" {
  ami               = "ami-0ed9277fb7eb570c9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "alex-personal-aws"
  network_interface {
    network_interface_id = aws_network_interface.a4l-vpc01-nic1.id
    device_index         = 0
  }

  //get meta data from ec2 AMI for EC2
  //https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
  //  rm /var/www/html/index.html - do not need this unless its ubuntu, for ami's httpd
  // ami's we use yum and here is how to enalbe the repo
  //https://gist.github.com/n1mh/13b40127349351db07c3c14a32da2706

  user_data = <<-EOF
  #!/bin/bash
  sudo su
  yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum update -y 
  yum -y install mtr
  yum -y install iperf
  yum -y install iperf3
  yum -y install httpd 
  echo '<!DOCTYPE html> <html lang=en> <head>  ' >> /var/www/html/index.html
  echo ' <script> var d = new Date(); ' >> /var/www/html/index.html
  echo ' var starttime = d.getMilliseconds(); ' >> /var/www/html/index.html
  echo ' </script> ' >> /var/www/html/index.html
  echo ' <div id="loadtime"></div> ' >> /var/www/html/index.html
  echo ' <div id="starttime"></div> ' >> /var/www/html/index.html
  echo ' <div id="endtime"></div> </head>' >> /var/www/html/index.html
  echo '<center><body bgcolor="black" text="#39ff14" style="font-family: Arial"> <title> Alkira Demo</title> <img src = "https://www.alkira.com/wp-content/uploads/2020/07/Frame_3x-1_c4f325530c6dbe993aa3b24e9d57381c.png"> </img> ' >> /var/www/html/index.html
  echo '<h1> Alkira Demo</h1><h3>Availability Zone: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/placement/availability-zone >> /var/www/html/index.html
  echo '</h3> <h3>Instance Id: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html
  echo '</h3>' >> /var/www/html/index.html
  echo '<h3>Local IP: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/local-ipv4 >> /var/www/html/index.html
  echo '</h3>' >> /var/www/html/index.html
  echo ' <h3>Local Hostname: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/local-hostname >> /var/www/html/index.html
  echo '</h3>' >> /var/www/html/index.html
  echo '<a href="https://web.dev/measure/"> LightHouse </a> ' >> /var/www/html/index.html
  echo '<footer> ' >> /var/www/html/index.html
  echo '<script type='text/javascript'> ' >> /var/www/html/index.html
  echo 'var d2 = new Date(); ' >> /var/www/html/index.html
  echo 'var endtime = d2.getMilliseconds(); ' >> /var/www/html/index.html
  echo 'var totaltime = ( (endtime - starttime)/1000); ' >> /var/www/html/index.html
  echo 'document.getElementById("starttime").innerHTML = "start time: " + starttime + " milliseconds"; ' >> /var/www/html/index.html
  echo 'document.getElementById("endtime").innerHTML = "end time: " + endtime + " milliseconds"; ' >> /var/www/html/index.html
  echo 'document.getElementById("loadtime").innerHTML = "Page loaded in: " + totaltime + " seconds"; ' >> /var/www/html/index.html
  echo '</script> </footer></html> ' >> /var/www/html/index.html
  service httpd restart
  EOF

  tags = {
    Name = "a4l-bastion"
  }
}


//testing the ec2 instance for private host.
// Create Ubuntu and install/enable httpd - Create an ec2 instance

resource "aws_security_group" "a4l-internal-sg" {
  name        = "allow_ssh_traffic"
  description = "Allow SSH Traffic"
  vpc_id      = aws_vpc.a4l-vpc1.id
  //wan
  ingress {
    cidr_blocks = ["0.0.0.0/0"] //this is my public ip when I vpn
    description = "all traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = false
  }
  tags = {
    Name = "Ingress SSH"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "all traffic"
    from_port   = 0
    to_port     = -1
    protocol    = "all"
    self        = false
  }

}



resource "aws_network_interface" "a4l-vpc01-nic2" {
  subnet_id = aws_subnet.a4l-vpc1-sub2b.id
  //private_ips = [""]
  //map_public_ip_on_launch = true
  security_groups = [aws_security_group.a4l-internal-sg.id]
  tags = {
    Name = "a4l-internal-nic"
  }


}


resource "aws_instance" "a4l-ec2-internal" {
  ami               = "ami-0ed9277fb7eb570c9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1b"
  key_name          = "alex-personal-aws"
  network_interface {
    network_interface_id = aws_network_interface.a4l-vpc01-nic2.id
    device_index         = 0
  }
  tags = {
    Name = "a4l-internal"
  }
}


//Creating a NAT Gateway

//need an eip
resource "aws_eip" "a4l-eip1" {
  vpc = true
  tags = {
    Name = "A4L-EIP-NAT-GW-A"
  }
}

resource "aws_nat_gateway" "a4l-natgw" {
  allocation_id = aws_eip.a4l-eip1.id
  subnet_id     = aws_subnet.a4l-vpc1-sub3a.id
  depends_on    = [aws_internet_gateway.a4l-igw]
  tags = {
    Name = "A4L-NAT-GW-A"
  }

}
resource "aws_eip" "a4l-eip2" {
  vpc = true
  tags = {
    Name = "A4L-EIP-NAT-GW-B"
  }
}

resource "aws_nat_gateway" "a4l-natgw-B" {
  allocation_id = aws_eip.a4l-eip2.id
  subnet_id     = aws_subnet.a4l-vpc1-sub3b.id
  depends_on    = [aws_internet_gateway.a4l-igw]
  tags = {
    Name = "A4L-NAT-GW-B"
  }

}


resource "aws_eip" "a4l-eip3" {
  vpc = true
  tags = {
    Name = "A4L-EIP-NAT-GW-C"
  }
}

resource "aws_nat_gateway" "a4l-natgw-C" {
  allocation_id = aws_eip.a4l-eip3.id
  subnet_id     = aws_subnet.a4l-vpc1-sub3c.id
  depends_on    = [aws_internet_gateway.a4l-igw]
  tags = {
    Name = "A4L-NAT-GW-C"
  }

}

//create private route tables for nat gateways in the respective AZ's

resource "aws_route_table" "a4l-vpc1-rt-privateA" {
  vpc_id = aws_vpc.a4l-vpc1.id
  route {
    //cidr_block = aws_vpc.am-vpc-tf.cidr_block
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.a4l-natgw.id
  }
  tags = {
    Name = "a4l-Private-AZ-A"
  }
}

resource "aws_route_table_association" "db-sub1a-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub1a.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateA.id

}


resource "aws_route_table_association" "ap-sub2a-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub2a.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateA.id
}

//App & DB in AZ B
resource "aws_route_table" "a4l-vpc1-rt-privateB" {
  vpc_id = aws_vpc.a4l-vpc1.id
  route {
    //cidr_block = aws_vpc.am-vpc-tf.cidr_block
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.a4l-natgw-B.id
  }
  tags = {
    Name = "a4l-Private-AZ-B"
  }
}

resource "aws_route_table_association" "db-sub1b-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub1b.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateB.id

}


resource "aws_route_table_association" "ap-sub2b-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub2b.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateB.id
}

//App & DB for C

resource "aws_route_table" "a4l-vpc1-rt-privateC" {
  vpc_id = aws_vpc.a4l-vpc1.id
  route {
    //cidr_block = aws_vpc.am-vpc-tf.cidr_block
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.a4l-natgw-C.id
  }
  tags = {
    Name = "a4l-Private-AZ-C"
  }
}

resource "aws_route_table_association" "db-sub1c-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub1c.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateC.id

}


resource "aws_route_table_association" "ap-sub2c-private" {
  subnet_id      = aws_subnet.a4l-vpc1-sub2c.id
  route_table_id = aws_route_table.a4l-vpc1-rt-privateC.id
}

 */












/*


THIS IS FOR REFERENCE OF THE RESOURCE NOT PART OF THE AWS TRAINING.



/4. Create Subnet for our EC2 subnet

resource "aws_subnet" "am-tf-sub1" {
  vpc_id            = aws_vpc.am-vpc-tf.id
  cidr_block        = "10.55.1.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "am-tf-sub"
  }
}

//5. Associate subnet with Route Table, this will also associate your instance
resource "aws_route_table_association" "am-tf-rt" {
  subnet_id      = aws_subnet.am-tf-sub1.id
  route_table_id = aws_route_table.am-tf-rt1.id
}
//6. Create an SG

resource "aws_security_group" "am-tf-sg" {
  name        = "allow_web_traffic"
  description = "Allow Web Traffic"
  vpc_id      = aws_vpc.am-vpc-tf.id
  ingress {
    cidr_blocks      = ["38.99.101.109/32"] //this is my public ip when I vpn
    //ipv6_cidr_blocks = ["38.99.101.109/32"]
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    self             = false
  }

  ingress {
    cidr_blocks      = ["38.99.101.109/32"]
    //ipv6_cidr_blocks = ["38.99.101.109/32"]
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    self             = false
  }

  ingress {
    cidr_blocks      = ["38.99.101.109/32"]
    //ipv6_cidr_blocks = ["38.99.101.109/32"]
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    self             = false
  }
  ingress {
    cidr_blocks      = ["38.99.101.109/32"]
    //ipv6_cidr_blocks = ["38.99.101.109/32"]
    description      = "ICMP"
    from_port        = 0
    to_port          = -1
    protocol         = "icmp"
    self             = false
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "all traffic"
    from_port   = 0
    to_port     = -1
    protocol    = "all"
    self        = false
  }
}


//7. Create a NIC with an ip of sub in 4resource

resource "aws_network_interface" "am-tf-1-nic" {

  subnet_id       = aws_subnet.am-tf-sub1.id
  private_ip      = "10.55.1.254"
  security_groups = [aws_security_group.am-tf-sg.id]

  //attachment {
  //instance = aws_instance.am-tf-1.id
  //device_index = 1
  //}


}
//8. Assign an EIP to the nic from step 7

resource "aws_eip" "am-tf-eip" {
  vpc               = true
  network_interface = aws_network_interface.am-tf-1-nic.id
  depends_on = [
    aws_internet_gateway.am-tf-igw
  ]
  //we actually don't need this.
  #associassociate_with_private_ip = "10.55.0.254"

}
//9. Create Ubuntu and install/enable httpd - Create an ec2 instance
resource "aws_instance" "am-tf-1" {
  ami               = "ami-0d382e80be7ffdae5"
  instance_type     = "t2.micro"
  availability_zone = "us-west-1b"
  key_name          = "alex-temp-MAC"
  network_interface {
    network_interface_id = aws_network_interface.am-tf-1-nic.id
    device_index         = 0
  }
  #Verify the repos are good
  #ls /etc/yum.repos.d
  #amzn2-core.repo  amzn2-extras.repo  epel.repo  epel-testing.repo
  //install the program and enable the repo
  #sudo yum -y install <program> --enablerepo epel
  //Verify the repo is enabled.
  #grep -i enabled /etc/yum.repos.d/epel.repo
  #enabled=1
  #enabled=0
  #enabled=0
  //get meta data from ec2
  //https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
  user_data = <<-EOF
  #!/bin/bash
  sudo su
  apt-get update -y
  apt-get install apache2 unzip -y
  echo '<html><center><body bgcolor="black" text="#39ff14" style="font-family: Arial"><h1>AWS ANS AAVGC</h1><h3>Availability Zone: ' > /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/placement/availability-zone >> /var/www/html/index.html
  echo '</h3> <h3>Instance Id: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html
  echo '</h3> <h3>Public IP: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/public-ipv4 >> /var/www/html/index.html
  echo '</h3> <h3>Public Hostname: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/public-hostname >> /var/www/html/index.html
  echo '</h3> <h3>Local IP: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/local-ipv4 >> /var/www/html/index.html
  echo '</h3> <h3>Local Hostname: ' >> /var/www/html/index.html
  curl http://169.254.169.254/latest/meta-data/local-hostname >> /var/www/html/index.html
  echo '</h3></html> ' >> /var/www/html/index.html  
  EOF

  tags = {
    Name = "am-tf-host1"
  }
  */