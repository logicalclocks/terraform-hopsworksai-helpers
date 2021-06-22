output "region" {
  value = var.region
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.profile.name
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.profile.arn
}

output "instance_profile_role_arn" {
  value = data.aws_iam_instance_profile.profile.role_arn
}

output "ssh_key_pair_name" {
  value = aws_key_pair.key.id
}