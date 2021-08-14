# Input variable definitions

variable "mysql_version" {
    description = "MySql docker image version"
    type        = string
    default     = "5.7"
}

variable "docker_network" {
    description = "Docker network"
    type        = string
}

variable "mysql" {
    description = "MySql docker image version"
    type        = string
    default     = "mysql"
}

variable "mysql_env" {
    description = "Mysql default env"
    type        = list(string)
    default     = ["MYSQL_ROOT_PASSWORD=wordpress", "MYSQL_PASSWORD=wordpress", "MYSQL_USER=wordpress", "MYSQL_DATABASE=wordpress"]
}

variable "mysql_mount" {
    description = "Tags to apply to resources created by VPC module"
    type        = map(string)
    default = {
        type = "volume"
        target = "/var/lib/mysql"
        source = "db_data"
    }
}