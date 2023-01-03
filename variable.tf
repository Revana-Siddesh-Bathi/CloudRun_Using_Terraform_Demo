variable "path" {
    default = "/Users/sid/Desktop/GCP_CFT/Terraform_GCP/secret.json"
}
variable "project_id" {
    default = "terraformgcp-372918"
}
variable "zone" {
  default = "us-east1-b"
}
variable "region" {
  default = "us-east1"
}

variable "container_image" {
  default = "gcr.io/terraformgcp-372918/yaml2json-converter"
} 

variable cpus {
  type = number
  default = 1
  description = "Number of CPUs to allocate per container."
}

variable memory {
  type = number
  default = 256
}