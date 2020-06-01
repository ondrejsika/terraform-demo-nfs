variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email = var.cloudflare_email
  token = var.cloudflare_token
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}


module "nfs" {
  source  = "ondrejsika/do-nfs/module"
  version = "1.0.0"
  tf_ssh_key = data.digitalocean_ssh_key.ondrejsika
}

resource "cloudflare_record" "nfs" {
  domain = "sikademo.com"
  name   = "nfs"
  value  = module.nfs.ipv4_address
  type   = "A"
  proxied = false
}
