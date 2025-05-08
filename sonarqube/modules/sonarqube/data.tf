data "aws_key_pair" "key_name" {
  key_name           = "workstation-server"
  include_public_key = true


}
