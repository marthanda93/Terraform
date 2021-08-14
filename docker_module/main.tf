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
}

module "wordpress_setup" {
  source = "./modules/wordpress"
  docker_network = var.docker_network
}
