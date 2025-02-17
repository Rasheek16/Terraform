provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster"{
  source="../../../modules/services/webserver-cluster"

  cluster_name = module_cluster_rasheek
  db_remote_state_bucket  = "terraform-up-and-running-state-rasheek"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"

  min_size=2
  max_size=2
}