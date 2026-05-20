variable "alb_name" {
  type = string
}

variable "alb_internal" {
  type = bool
}

variable "alb_type" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "target_group_type" {
  type = string
}

variable "health_check_path" {
  type = string
}

variable "health_check_matcher" {
  type = string
}

variable "http_listener_port" {
  type = number
}

variable "http_listener_protocol" {
  type = string
}

variable "redirect_port" {
  type = string
}

variable "redirect_protocol" {
  type = string
}

variable "redirect_status_code" {
  type = string
}

variable "certificate_arn" {
  type = string
}
