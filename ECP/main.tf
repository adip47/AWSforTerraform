resource "aws_instance" "demoinstancee" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  associate_public_ip_address = true
  provisioner "file" {
    source      = "/home/ec2-user/AWSforTerraform/ecp/script.sh"
    destination = "/tmp/script.sh"
  }
 
  provisioner "file" {
   source = "/home/ec2-user/AWSforTerraform/ecp/tera-provision.pub"
   destination = "/home/ec2-user/.ssh/authorized_keys"
}
 
  connection {
    type = "ssh"
    user        = "ec2-user"
    private_key = "${file(var.private_key_path)}"
    host = self.public_ip
  }
 
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
 
  tags = {
    Name = "My Public Instance"
  }
}
 
resource "aws_key_pair" "testing-tera" {
  key_name = "tera-provision"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsVmj8w1HfNzqCwfsgn+jis7ReIWTguZQVM4WkbxE0CvJTi/JHch8v74JHlrq6lgYGSGYtVpJ4xfTiyYqj3FVCH6X4PdNmJbYq/a/wB1qLFqAShqXC+eef62ALoPuNY08R2q/AgFDurndFAUXzN7e7PF+LtDLivZD6o3lEbnOc4f/5mhTV5/PtDtL97CYCYqvinPuv83j6SkeKDqFD5xENYCAwE0mhTwChlkOvN223UiTDXvJXcVnXnS/zRWJixzStm2Z5lKSg/Cy7D874RqVnecDQOwpbvubNYn+rcaaVm26ZKAr1Y9WUD0/NfzMSFO/BrBk+Crm/j/awVV3ZOX4DYhvxgPpArNpGVSt9xD1K6KKbgQBTKe9HS7OqYzyHpv+bzvysH78DiKBhW5m/eWA4I8kv6dylsqtpBZ0lRNxNmyoPWlS1nSvp5phzXNuH2ZZKHu0a00tU9lTvEPJwIg0LbUdYNFdlxc+UQb3ufSKFI1HlvfGXrqy05GGOI8QCpM8= ec2-user@ip-172-31-80-137.ec2.internal"
}
#============working code for local exec=======
 
resource "aws_instance" "web" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.private_ip}"
  }
}
