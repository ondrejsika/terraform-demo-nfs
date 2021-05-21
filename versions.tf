terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.19.0"
    }
    digitalocean = {
      source = "terraform-providers/digitalocean"
    }
  }
  required_version = ">= 0.13"
}
