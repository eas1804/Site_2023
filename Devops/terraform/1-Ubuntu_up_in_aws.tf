################ 1. Вводим учетные данные ###################
## Input credential in shell
## export AWS_ACCESS_KEY_ID="AKIA5URE..."
## export AWS_SECRET_ACCESS_KEY="l4s3ZLB...."
## export AWS_REGION="us-east-1"

## Запуск terraform apply
## 

## 2. Описываем ресурс вируальной машины ######
resource "aws_instance" "example" {
  ami           = "ami-0044130ca185d0880"
  instance_type = "t2.micro"
  key_name      = "Luda2-cli"
  vpc_security_group_ids = ["sg-0da532254a49eba2f"]
  tags = {
    Name = "For_portknoking"
  }
}

# 3. Вывод ip адреса
output "instance_ip" {
  value = aws_instance.example.public_ip
}