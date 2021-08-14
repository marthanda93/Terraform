variable "docker_network" {
    description = "Docker Network for mysql and wordpress"
    type        = string
    default     = "wordpress_net"
}