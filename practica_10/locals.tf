locals {
  suffix = "${var.tags.project}-${var.tags.env}-${var.tags.region}" # recurso-cerberus-prod-region
}

resource "random_string" "sufijo_s3" {
  length = 8
  special = false
  upper = false

}

locals {
  s3-suffix = "${var.tags.project}-${random_string.sufijo_s3.id}"
}