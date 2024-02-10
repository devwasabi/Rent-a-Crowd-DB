provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner         = "Sean.vanWyk@bbd.co.za"
      created-using = "Terraform"
    }
  }
}
