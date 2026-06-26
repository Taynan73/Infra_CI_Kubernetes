module "eks" {
  source = "terraform-aws-modules/eks/aws"

  name                    = var.cluster_name
  kubernetes_version                 = "1.34"

  endpoint_public_access  = true
  endpoint_private_access  = true

  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns                = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
      # most_recent = true
    }
    kube-proxy             = {
      before_compute = true
      # most_recent = true
    }
    vpc-cni                = {
      before_compute = true
      # most_recent = true
    }
  }

  eks_managed_node_groups = {
    alura = {
      ami_type       = "AL2023_x86_64_STANDARD"
      min_size     = 1
      max_size     = 10
      desired_size = 3
      # vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types = ["t2.micro"]
    }
  }
}
