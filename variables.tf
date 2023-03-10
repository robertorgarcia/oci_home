#TODO extract credentials as variables


locals {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaackqfprgd6lmhca2l2c3cbyu7766sl6yuyssa5he67gi6azsxpia"
}

variable "user_ocid" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "fingerprint" {
  type = string
}
variable "region" {
  type = string
}
variable "namespace" {
  type = string
}
