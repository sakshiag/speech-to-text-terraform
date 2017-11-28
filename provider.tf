variable "bluemix_api_key" {
}

provider "ibm" {
  region = "${var.region}"
  bluemix_api_key = "${var.bluemix_api_key}"

}