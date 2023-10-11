resource "tls_private_key" "pk-east-1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp-east-1" {
  provider   = aws.east-1
  key_name   = "KP-east-1"
  public_key = tls_private_key.pk-east-1.public_key_openssh
}

resource "local_file" "ssh_key-east-1" {
  filename = "${aws_key_pair.kp-east-1.key_name}.pem"
  content  = tls_private_key.pk-east-1.private_key_pem # we can save private key to our local file
  #content = tls_private_key.pk.public_key_pem #we can also save public key  to our local file
}

resource "tls_private_key" "pk-east-2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp-east-2" {
  provider   = aws.east-2
  key_name   = "KP-east-2"
  public_key = tls_private_key.pk-east-2.public_key_openssh
}

resource "local_file" "ssh_key-east-2" {
  filename = "${aws_key_pair.kp-east-2.key_name}.pem"
  content  = tls_private_key.pk-east-2.private_key_pem # we can save private key to our local file
  #content = tls_private_key.pk.public_key_pem #we can also save public key  to our local file
}