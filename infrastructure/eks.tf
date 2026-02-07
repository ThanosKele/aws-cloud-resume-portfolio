# 1. Δημιουργία Δικτύου (VPC)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "thanos-portfolio-vpc"
  cidr = "10.0.0.0/16"

  # Χρειαζόμαστε τουλάχιστον 2 Availability Zones για το EKS
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true # Επιτρέπει στα nodes να βγαίνουν στο internet για updates
  single_nat_gateway = true # Για οικονομία!
  
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1 # Χρειάζεται για να φτιάχνει το K8s Load Balancers
  }
}

# 2. Δημιουργία του EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "thanos-resume-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Επιτρέπει στον χρήστη μου (που τρέχει το Terraform) να είναι admin του cluster
  enable_cluster_creator_admin_permissions = true

  # 3. Managed Node Groups (Οι Servers μας)
  eks_managed_node_groups = {
    main = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      # Οι t3.medium είναι οι ελάχιστες προτεινόμενες για να μην κολλάει το K8s
      instance_types = ["t3.medium"] 
    }
  }
  cluster_endpoint_public_access = true
  enable_irsa = true
}