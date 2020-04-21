provider "aws" {
  profile = "default"
  region  = var.region
}


resource "aws_kinesis_stream" "chat_stream" {
  name        = "kinesis-chat"
  shard_count = var.shard_count
}


resource "aws_instance" "producer" {
  ami                  = "ami-0323c3dd2da7fb37d"
  instance_type        = "t2.micro"
  count                = 5
  user_data            = file("Producer.sh")
  iam_instance_profile = aws_iam_instance_profile.kinesis_profile.name
  depends_on = [
    aws_kinesis_stream.chat_stream,
  ]

  tags = {
    Name = element(var.instance_names, count.index)
  }
}


resource "aws_instance" "consumer" {
  ami                  = "ami-0323c3dd2da7fb37d"
  instance_type        = "t2.micro"
  key_name             = var.key_name
  user_data            = file("Consumer.sh")
  iam_instance_profile = aws_iam_instance_profile.kinesis_profile.name
  depends_on = [
    aws_kinesis_stream.chat_stream,
  ]

  tags = {
    Name = "Consumer"
  }
}
