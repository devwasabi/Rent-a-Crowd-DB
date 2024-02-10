terraform {
  backend "s3" {
    bucket  = "rentacrowd-tfstate" # name of the s3 bucket you created
    key     = "dblevelup/terraform.tfstate"
    region  = "eu-west-1"
  }
}