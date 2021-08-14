#resources

resource "docker_network" "wordpress_net" {
  name = var.docker_network
}