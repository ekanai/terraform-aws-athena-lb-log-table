variable "database_name" {
  type        = string
  description = "Database name"
}

variable "table_name" {
  type        = string
  description = "Table name"
}

variable "location" {
  type        = string
  description = <<EOF
    ex) s3://bucket-name/prefix/
  EOF
}
