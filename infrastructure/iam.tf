resource "aws_iam_user" "ansible" {
  name = "ansible-homeassistant"

  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_access_key" "ansible" {
  user = aws_iam_user.ansible.name
}

resource "local_sensitive_file" "foo" {
  content  = <<EOF
AWS_ACCESS_KEY_ID: ${aws_iam_access_key.ansible.id}
AWS_SECRET_ACCESS_KEY: ${aws_iam_access_key.ansible.secret}
  EOF
  filename = "../ansible/aws_secrets.yaml"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "homeassistant-backup-access"
  user = aws_iam_user.ansible.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.bucket.arn}"
    }
  ]
}
EOF
}

