

module "vpc" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=f63156b04221ed0d16ef7d5a2ec68a94b80cddf1"
  version = "3.19.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}



module "eks_role" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-eks-role?ref=8925c55d5cab13995faddcd32f55d6168988fa45"
  version = "4.13.0"

  role_name = "eks-cluster-role"
}





module "eks" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=5a0c20d4e48a6c989213a77e8f2bf339984d79da"
  version = "15.2.0"

  cluster_name    = "simple-eks"
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  node_groups = {
    ng = {
      instance_types = ["t2.medium"]
      desired_size   = 1
    }
  }
}
