// Virtual Private Cloud
//https://registry.terraform.io/modules/gruntwork-io/network/google/latest/submodules/vpc-network
module "network_vpc-network" {
  source  = "gruntwork-io/network/google//modules/vpc-network"
  version = "0.8.1"
  # insert the 5 required variables here
  project     = var.project
  name_prefix = var.name_prefix
  region      = var.region
}
