variable "region" {
  description = "GCP Region"
}

variable "project" {
  description = "GCP Project ID"
}

variable "gke_username" {
    default     = ""
    description = "gke username"
}

variable "gke_password" {
  default     =  ""
  description = "value"
}

variable "gke_num_nodes" {
    default     =   ""
    description = "number of gke nodes"
}