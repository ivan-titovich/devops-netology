module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "ExampleAppServerInstance"

  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}