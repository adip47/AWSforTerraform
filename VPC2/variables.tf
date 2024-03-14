variable "public_subnet_cidrs" {
description = "Public Subnet CIDR values"
default     = "10.0.1.0/24"
}
 
variable "private_subnet_cidrs" {
description = "Private Subnet CIDR values"
default     = "10.0.4.0/24"
}
 
 
variable "azs" {
description = "Availability Zones"
default     = "us-east-1a"
}
 
variable "env_name" {
default  = "dev"
}
