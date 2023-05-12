variable "oci_tenancy" {
  type = string
  description = "Oracle Cloud Identifier tenancy"
}
variable "oci_user" {
  type = string
  description = "Oracle Cloud Identifier user"
}
variable "oci_fingerprint" {
  type = string
  description = "Oracle Cloud Fingerprint for the key pair"
}
variable "oci_key" {
  type = string
  description = "Oracle Cloud key"
}
variable "oci_region" {
  type = string
  description = "Oracle Cloud region"
}
variable "oci_compartment" {
  type = string
  description = "Oracle Cloud Compartment"
}

variable "shape" {
  type = string
  description = "Oracle Cloud shape"
}

variable "instance_availability_domain" {
  type = string
  description = "Oracle Cloud domain"
}

variable "linux_source_id" {
  type = string
  description = "linux source id"
}

variable "window_source_id" {
  type = string
  description = "window source id"
}

