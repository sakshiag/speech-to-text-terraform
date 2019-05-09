variable "space" {
}

variable "org" {
}


variable "region" {
default = "eu-de"
}

variable "datacenter" {
	default = "ams03"
}

variable "machine_type" {
default = "u2c.2x4"
}

variable "isolation" {
default = "public"
}

variable "private_vlan_id" {

}

variable "public_vlan_id" {

}

/*variable "subnet_id" {
}*/

variable "service_instance_name" {
  default = "speech-to-text-service"
}

variable "service_key" {
  default = "myservicekey"
}

variable "service_offering" {
  default = "speech_to_text"
}

variable "plan" {
  default = "standard"
}

variable "cluster_name" {
  default = "speech-to-text"
}

