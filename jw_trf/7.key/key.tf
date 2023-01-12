# key_pair
resource "aws_key_pair" "mykey" {
  key_name_prefix = "mykey"
  public_key      = file("mykey.pub")
}
