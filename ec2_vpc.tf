resource "aws_key_pair" "key-rsc" {
	key_name = "terra-key"
	public_key = file("/home/ubuntu/.ssh/terra-key.pub")

}

resource "aws_instance" "my-vpc-instance-rsc" {
	instance_type = "t2.micro"
	key_name = aws_key_pair.key-rsc.key_name
	security_groups= [aws_security_group.security-group-rsc.name]
	ami = var.ec2-ubuntu-ami
}

resource "aws_default_vpc" "default-vpc-rsc" {}

resource "aws_security_group" "security-group-rsc" {
			name = "allow-ssh"
			description = "Allow ssh inbound traffic"
		ingress {
			
			protocol = "tcp"
			from_port = 22
			to_port = 22
			cidr_blocks = ["0.0.0.0/0"]
		}
			vpc_id = aws_default_vpc.default-vpc-rsc.id
			
			tags = {

				name = "allow-ssh"
				}
		}
