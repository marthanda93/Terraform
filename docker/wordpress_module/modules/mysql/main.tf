resource "docker_volume" "db_data" {}

# Pulls the image
resource "docker_image" "mysql" {
    name = "${var.mysql}:${var.mysql_version}"
}

resource "docker_container" "db" {
    name  = var.db_name
    image = docker_image.mysql.name
    restart = var.db_restart
    network_mode = var.docker_network
    env = var.mysql_env
    mounts {
        type = "volume"
        target = "/var/lib/mysql"
        source = "db_data"
    }
}