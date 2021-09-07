provider "docker" {
  host = "unix:///var/run/docker.sock"
}

module "common_setup" {
  source = "./modules/common"
  docker_network = var.docker_network
}

module "mysql_setup" {
  source = "./modules/mysql"
  docker_network = var.docker_network
  db_name = var.db_name
  db_restart = var.db_restart
}

module "wordpress_setup" {
  source = "./modules/wordpress"
  docker_network = var.docker_network
}

variable "app_restart" {
    description = "container restart"
    type        = string
}

variable "app_name" {
    description = "container name"
    type        = string
}