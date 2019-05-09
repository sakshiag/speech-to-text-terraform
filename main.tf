data "ibm_org" "org" {
  org = "${var.org}"
}

data "ibm_space" "space" {
  org   = "${var.org}"
  space = "${var.space}"
}

data "ibm_account" "account" {
  org_guid = "${data.ibm_org.org.id}"
}

/*resource "ibm_container_cluster" "cluster" {
  name         = "${var.cluster_name}"
  datacenter   = "${var.datacenter}"
  org_guid     = "${data.ibm_org.org.id}"
  space_guid   = "${data.ibm_space.space.id}"
  account_guid = "${data.ibm_account.account.id}"
  no_subnet    = true
  //subnet_id    = ["${var.subnet_id}"]

  workers = [{
    name   = "worker1"
    action = "add"
  },
    {
      name   = "worker2"
      action = "add"
    },
    {
      name   = "worker3"
      action = "add"
    },
  ]

  machine_type    = "${var.machine_type}"
  isolation       = "${var.isolation}"
  public_vlan_id  = "${var.public_vlan_id}"
  private_vlan_id = "${var.private_vlan_id}"
}*/

resource "ibm_service_instance" "service" {
  name       = "${var.service_instance_name}"
  space_guid = "${data.ibm_space.space.id}"
  service    = "${var.service_offering}"
  plan       = "${var.plan}"
  tags       = ["speech-to-text-service"]
}

resource "ibm_service_key" "key" {
  name                  = "${var.service_key}"
  service_instance_guid = "${ibm_service_instance.service.id}"
}

resource "ibm_container_bind_service" "bind_service" {
  cluster_name_id             = "speech-to-text"
  service_instance_space_guid = "${data.ibm_space.space.id}"
  service_instance_name_id    = "${ibm_service_instance.service.id}"
  namespace_id                = "default"
  org_guid                    = "${data.ibm_org.org.id}"
  space_guid                  = "${data.ibm_space.space.id}"
  account_guid                = "${data.ibm_account.account.id}"
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = "speech-to-text"
  org_guid        = "${data.ibm_org.org.id}"
  space_guid      = "${data.ibm_space.space.id}"
  account_guid    = "${data.ibm_account.account.id}"
}

resource "null_resource" "verify_cluster" {
  depends_on = ["template_dir.config"]
  provisioner "local-exec" {
    command = <<EOF
        export KUBECONFIG="${data.ibm_container_cluster_config.cluster_config.config_file_path}"
        kubectl create -f ${path.cwd}/config/speech_to_text_pod.yaml
        kubectl create -f ${path.cwd}/config/ingress_service.yaml
        kubectl get pods
        EOF
  }
}

resource "random_id" "name" {
  byte_length = 4
}

data "ibm_container_cluster" "cluster" {
    org_guid        = "${data.ibm_org.org.id}"
  space_guid      = "${data.ibm_space.space.id}"
  account_guid    = "${data.ibm_account.account.id}"
    cluster_name_id = "speech-to-text"
}

resource "template_dir" "config" {
  source_dir      = "${path.module}/config_template"
  destination_dir = "${path.cwd}/config"

  vars {
    service_name = "${ibm_service_instance.service.name}"
    host_name = "${data.ibm_container_cluster.cluster.ingress_hostname}"
  }
}



output "app_url" {
  value = "${data.ibm_container_cluster.cluster.ingress_hostname}"
}
