variable "instance_type" {
  description = "The instance type used to create the virtual machine (ec2 instance)"
  type    = string
  default = "t2.nano"
}

variable "ec2_role_name" {
  description = "The IAM role used to allow the virtual machine (ec2 instance) to access other AWS resourcers"
  type    = string
  default = "MainServer"
}