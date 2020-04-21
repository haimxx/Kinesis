resource "aws_iam_role" "kinesis_role" {
  name = "kinesis_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_instance_profile" "kinesis_profile" {
  name = "kinesis_profile"
  role = aws_iam_role.kinesis_role.name
}


resource "aws_iam_role_policy" "kinesis_policy" {
  name = "kinesis_policy"
  role = aws_iam_role.kinesis_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kinesis:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
