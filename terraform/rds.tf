module "rds" {
  source = "terraform-aws-modules/rds/aws"
  engine = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  name = "flaskappdb"
  username = "admin"
  password = "password"
  subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]
}
