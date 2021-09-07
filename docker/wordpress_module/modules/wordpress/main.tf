# Pulls the image
resource "docker_image" "wordpress" {
    name = "${var.app_name}:${var.wordpress_version}"
}

resource "docker_container" "wordpress" {
    name  = var.app_name
    image = docker_image.wordpress.latest
    restart = var.app_restart
    network_mode = var.docker_network
    env = var.wordpress_env
    ports {
        internal = "80"
        external = "8080"
    }
}