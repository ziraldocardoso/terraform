variable "http_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "The port the server will use for HTTPS requests"
  type        = number
  default     = 443
}

variable "ssh_port" {
  description = "The port the server will use for SSH requests"
  type        = number
  default     = 47022
}
