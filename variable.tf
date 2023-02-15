


variable "vpc_num" {
   default= 2
  description = " numuber of vpc in same region"
  type = number
}


variable "region_num" {
   default= 2
  description = " numuber of region"
  type = number
}

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







