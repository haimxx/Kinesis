variable "region" {
  default = "us-east-1"
}


variable "shard_count" {
  default = 1
}


variable "instance_names" {
  type = list(string)
  default = ["Producer-1", "Producer-2", "Producer-3",
  "Producer-4", "Producer-5"]
}


variable "key_name" {
  default = "MyKey"
}

