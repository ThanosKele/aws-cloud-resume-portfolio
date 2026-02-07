# 1. Δημιουργία του Role με Trust Policy για το EKS
resource "aws_iam_role" "dynamodb_role" {
  name = "thanos-resume-dynamodb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc_provider_arn
        }
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" : "system:serviceaccount:default:resume-api-sa"
          }
        }
      },
    ]
  })
}

# 2. Σύνδεση του Role με το DynamoDB policy
resource "aws_iam_role_policy_attachment" "dynamodb_attach" {
  role       = aws_iam_role.dynamodb_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}