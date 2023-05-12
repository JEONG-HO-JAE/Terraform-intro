#make a vm in AWS
resource "aws_instance" "FirstInstance" {
	#VM info
        ami = data.aws_ami.linux.id
        instance_type = "t2.micro"
	subnet_id = aws_subnet.hojae_subnet.id
	associate_public_ip_address = true
	vpc_security_group_ids = [aws_security_group.hojae_sg.id]

	#SSH key
        key_name = aws_key_pair.hojae.key_name

        tags = {
                Name = "Number_one_instance"
                devOps = "terraform"
                os = "Linux"
                cloud = "AWS"
        }
}



resource "aws_instance" "SecondInstance" {

        #VM info
        ami = data.aws_ami.windows.id
        instance_type = "t2.micro"
	subnet_id = aws_subnet.hojae_subnet.id
	associate_public_ip_address = true
        vpc_security_group_ids = [aws_security_group.hojae_sg.id]


  user_data = <<EOF
<powershell>
$admin = [adsi]("WinNT://./${var.win_username}, user")
$admin.PSBase.Invoke("SetPassword", "${var.win_password}")
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
</powershell>
EOF

        #SSH key
        key_name = aws_key_pair.hojae.key_name

        tags = {
                Name = "Number_two_instance"
                devOps = "terraform"
		os = "Windows"
		cloud = "AWS"
        }

}

resource "aws_key_pair" "hojae" {
  key_name   = "hojae"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDb5Kdl0Bf+hRqcNEn82x3flFxoTh8GvpOBSFn9vJJmQtXqnPP5FJ+afA6hmBVuMfVBSCdBE9plgtfqEMqq/I1yxgspKejy01XLaEyLsvx3m5y1F4rtv/Sn+UO/4/6JJ/HdLUxLpO3TRN1w6EVrqUjr88Jg8rEAcWnGUL5G875cpev878cAmCgWVVzr/1122wI/vDDXnP+zUG/dR4iZcbDSB7P70eVrMTZGMhiJYBF0Q4LuSyn6cKrWrM3yQg2uJ+/A+5MbQ4w+WPT6HZtZZRWcIiNwlw7wCQOi8jgNDeXaP9ETj+6MNqd6cliLKYp1onK19aypcyqVULm6calU1Uf9 centos@hojae-linux.novalocal"
}
