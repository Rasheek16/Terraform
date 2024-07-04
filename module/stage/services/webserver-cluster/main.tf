provider "aws" {
  region = "us-east-2"
}

odule "webserver_cluster"{
  source=" ../../../../../modules/
}