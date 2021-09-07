# Input variable definitions

variable "wordpress_version" {
    description = "MySql docker image version"
    type        = string
    default     = "latest"
}

variable "docker_network" {
    description = "Docker network"
    type        = string
}

variable "app_restart" {
    description = "container restart"
    type        = string
}

variable "app_name" {
    description = "container name"
    type        = string
}

variable "wordpress_env" {
    description = "Mysql default env"
    type        = list(string)
    default     = ["WORDPRESS_DB_HOST=db:3306", "WORDPRESS_DB_PASSWORD=wordpress"]
}

variable "wordpress_port" {
    description = "Tags to apply to resources created by VPC module"
    type        = map(string)
    default = {
        internal = "80"
        external = "8080"
    }
}