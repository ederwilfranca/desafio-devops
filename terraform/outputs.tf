output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.private_subnets
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_address
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}

output "ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}
