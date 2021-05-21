variable "do_token" {}
variable "cloudflare_api_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  sikademo_com_zone_id = "f2c00168a7ecd694bb1ba017b332c019"
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}


module "nfs" {
  source  = "ondrejsika/do-nfs/module"
  version = "1.1.0"
  tf_ssh_key = data.digitalocean_ssh_key.ondrejsika
}

resource "cloudflare_record" "nfs" {
  zone_id = local.sikademo_com_zone_id
  name   = "nfs"
  value  = module.nfs.ipv4_address
  type   = "A"
  proxied = false
}
