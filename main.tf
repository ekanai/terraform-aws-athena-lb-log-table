resource "time_static" "now" {}

locals {
  partiotion_year_range_from = var.partiotion_year_range_from == 0 ? time_static.time.year - 3 : var.partiotion_year_range_from
  partiion_year_range_to     = var.partiion_year_range_to == 0 ? time_static.time.year : var.partiion_year_range_to
}

resource "aws_glue_catalog_table" "table" {
  database_name = var.database_name
  name          = var.table_name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "has_encrypted_data"        = false
    "projection.day.digits"     = "2",
    "projection.day.range"      = "01,31",
    "projection.day.type"       = "integer",
    "projection.enabled"        = "true",
    "projection.month.digits"   = "2",
    "projection.month.range"    = "01,12",
    "projection.month.type"     = "integer",
    "projection.year.digits"    = "4",
    "projection.year.range"     = "${var.year_range_from},${time_static.time.year}",
    "projection.year.type"      = "integer",
    "storage.location.template" = "${var.location}/$${year}/$${month}/$${day}"
  }

  partition_keys {
    name = "year"
    type = "int"
  }

  partition_keys {
    name = "day"
    type = "int"
  }

  partition_keys {
    name = "month"
    type = "int"
  }

  storage_descriptor {
    location      = var.location
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.RegexSerDe"

      parameters = {
        "serialization.format" = "1"
        "input.regex"          = "([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) ([^ ]*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^s]+?)\" \"([^s]+)\" \"([^ ]*)\" \"([^ ]*)\""
      }
    }

    columns {
      name = "type"
      type = "string"
    }

    columns {
      name = "time"
      type = "string"
    }

    columns {
      name = "elb"
      type = "string"
    }

    columns {
      name = "client_ip"
      type = "string"
    }

    columns {
      name = "client_port"
      type = "int"
    }

    columns {
      name = "target_ip"
      type = "string"
    }

    columns {
      name = "target_port"
      type = "int"
    }

    columns {
      name = "request_processing_time"
      type = "double"
    }

    columns {
      name = "target_processing_time"
      type = "double"
    }

    columns {
      name = "response_processing_time"
      type = "double"
    }

    columns {
      name = "elb_status_code"
      type = "string"
    }

    columns {
      name = "target_status_code"
      type = "string"
    }

    columns {
      name = "received_bytes"
      type = "bigint"
    }

    columns {
      name = "sent_bytes"
      type = "bigint"
    }

    columns {
      name = "request_verb"
      type = "string"
    }

    columns {
      name = "request_url"
      type = "string"
    }

    columns {
      name = "request_proto"
      type = "string"
    }

    columns {
      name = "user_agent"
      type = "string"
    }

    columns {
      name = "ssl_cipher"
      type = "string"
    }

    columns {
      name = "ssl_protocol"
      type = "string"
    }

    columns {
      name = "target_group_arn"
      type = "string"
    }

    columns {
      name = "trace_id"
      type = "string"
    }

    columns {
      name = "domain_name"
      type = "string"
    }

    columns {
      name = "chosen_cert_arn"
      type = "string"
    }

    columns {
      name = "matched_rule_priority"
      type = "string"
    }

    columns {
      name = "request_creation_time"
      type = "string"
    }

    columns {
      name = "actions_executed"
      type = "string"
    }

    columns {
      name = "redirect_url"
      type = "string"
    }

    columns {
      name = "lambda_error_reason"
      type = "string"
    }

    columns {
      name = "target_port_list"
      type = "string"
    }

    columns {
      name = "target_status_code_list"
      type = "string"
    }

    columns {
      name = "classification"
      type = "string"
    }

    columns {
      name = "classification_reason"
      type = "string"
    }
  }
}
