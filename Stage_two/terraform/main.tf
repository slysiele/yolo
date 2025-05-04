terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

resource "local_file" "vagrant_init" {
  content  = "vagrant up --provision"
  filename = "${path.module}/vagrant_init.sh"
}

resource "null_resource" "vagrant_provision" {
  provisioner "local-exec" {
    command = "chmod +x ${local_file.vagrant_init.filename} && ${local_file.vagrant_init.filename}"
  }
}
