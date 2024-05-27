resource "aws_quicksight_data_set" "example" {
  data_set_id = "${var.name}-test"
  name        = "${var.name}"
  import_mode = "SPICE"

  physical_table_map {
    physical_table_map_id = "${var.name}"
    s3_source {
      data_source_arn = aws_quicksight_data_source.s3.arn
      input_columns {
        name = "Column1"
        type = "STRING"
      }
      upload_settings {
        format = "CSV"
      }
    }
  }
}