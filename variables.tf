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
    ex) s3://bucket-name/prefix
  EOF
}

variable "partition_year_range_from" {
  type        = number
  description = "Year range from"
  default     = 0
}

variable "partition_year_range_to" {
  type        = number
  description = "Year range to"
  default     = 0
}
