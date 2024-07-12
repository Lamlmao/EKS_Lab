locals {
  tags = {
    Environment = "${var.Environment}"
    Application = "${var.Application}"
  }
  name = "${var.Application}-${var.Environment}"
}
