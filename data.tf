data "terraform_remote_state" "tgw" {
  backend = "s3"
  config = {
    region = "ap-southeast-1"
    bucket = "infra-provisioning-terraform-remote-state"
    key    = "aws/cxa-group/environments/infra/cxa/ap-southeast-1/networks/tgw/terraform.tfstate"
  }
}
