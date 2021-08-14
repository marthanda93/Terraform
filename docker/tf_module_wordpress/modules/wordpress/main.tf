# Pulls the image
resource "docker_image" "wordpress" {
    name = "${var.wordpress}:${var.wordpress_version}"
}

resource "docker_container" "wordpress" {
    name  = var.wordpress
    image = docker_image.wordpress.latest
    restart = "no"
    network_mode = var.docker_network
    env = var.wordpress_env
    ports {
        internal = "80"
        external = "8080"
    }
}