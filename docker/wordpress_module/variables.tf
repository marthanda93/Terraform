variable "docker_network" {
    description = "Docker Network for mysql and wordpress"
    type        = string
    default     = "wordpress_net"
}

variable "db_restart" {
    description = "container restart"
    type        = string
}

variable "db_name" {
    description = "container name"
    type        = string
}