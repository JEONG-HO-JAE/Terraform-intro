# AWS_ami
data "aws_ami" "linux" {
	most_recent = true

	owners = ["amazon"]
	
	filter {
	 	name  = "name"
		values = ["al2023-ami-2023.0.20230329.0-kernel-6.1-x86_64"]
	}

	filter {
		name = "virtualization-type"
		values = ["hvm"]
	}

	filter {
		name = "architecture"
		values = ["x86_64"]
	}
}

data "aws_ami" "windows" {
        most_recent = true

        owners = ["amazon"]

        filter {
                name  = "name"
                values = ["Windows_Server-2022-English-Full-Base-2023.04.12"]
        }

        filter {
                name = "virtualization-type"
                values = ["hvm"]
        }

        filter {
                name = "architecture"
                values = ["x86_64"]
        }
}
