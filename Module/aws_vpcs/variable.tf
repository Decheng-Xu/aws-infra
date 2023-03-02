variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "vpc cidr block"
  type = string
}
variable "availability_zones" {
  default= ["us-west-2a", "us-west-2b", "us-west-2c"]
  description = "vpc cidr block"
  type = list
}

variable "vpc-tag" {
  default= ["us-west-2a", "us-west-2b", "us-west-2c"]
  description = "vpc cidr block"
  type = list
}


variable "vpc_name" {
   default= "my_vpc"
  description = "vpc name"
  type = string
}

variable "public_subnets_num" {
   default= 3
  description = "public subnets num"
  type = number
}

variable "private_subnets_num" {
  default= 3
  description = "private subnets num"
  type = number
}

variable "profile" {
  type = string
  description = "profile"
}

variable "region" {
   default= "us-west-2"
  description = "region name"
  type = string
}
variable "ami_id" {
   default= "ami-04e61c2967631a8e3"
  description = "ami_id"
  type = string
}

variable "public_key_path" {
   default= "~/.ssh/ec2.pub"
  description = "local path of key pair"
  type = string
}

variable "db-password" {
   default= "root1234"
  description = "password of db"
  type = string
}
variable "db-name" {
   default= "csye6225"
  description = "name of db"
  type = string
}

variable "db-username" {
   default= "root"
  description = "username of db"
  type = string
}

variable "AWS_ACCESS_KEY_ID" {
<<<<<<< HEAD
   default= "123"
=======
   default= "AKIASXLAYFSPGTHERZUJ"
>>>>>>> bb90cae (HW5_RDS)
  description = "id"
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
<<<<<<< HEAD
   default= "345"
=======
   default= "h2UT4l41LyxA9O4igX9ZQKNC04w5CTLAmon5MYLC"
>>>>>>> bb90cae (HW5_RDS)
  description = "key"
  type = string
}

variable "hostname" {
   default= "csye6225_DC"
  description = "name"
  type = string
}


<<<<<<< HEAD
# variable "root_zone_id" {
#   type = string
#   default = "Z00938262063SRV55QZB9"
#   description = "zone_id"
# }
# variable "dev_zone_id" {
#   type = string
#   default = "Z1010723CGDKV2QHQZHV"
#   description = "zone_id"
# }

# variable "demo_zone_id" {
#   type = string
#   default = "Z0056496EK576IZZQLBY"
#   description = "zone_id"
# }

variable "root_domain_name" {
  type = string
  default = "dechengxu.me"
  description = "name"
}

variable "dev_domain_name" {
  type = string
  default = "dev.dechengxu.me"
  description = "name"
}

variable "demo_domain_name" {
  type = string
  default = "demo.dechengxu.me"
  description = "name"
}

variable "application_port" {
  default= 8080
  description = "app port number"
  type = number
}

=======
>>>>>>> bb90cae (HW5_RDS)





