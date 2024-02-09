# terraform {
#   backend "s3" {
#     bucket  = "rentacrowd-tfstate" # name of the s3 bucket you created
#     key     = "production/terraform.tfstate"
#     region  = var.region
#     encrypt = true
#   }
# }