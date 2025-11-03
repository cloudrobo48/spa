# ----------------------------------------------------
# IAM for Apply Log Bucket
# ----------------------------------------------------

# This IAM role is assumed by GitHub Actions via OIDC.
# GitHub automatically issues an OIDC token during workflow execution.
# The token is used to call AWS STS:AssumeRoleWithWebIdentity and request temporary credentials.
# The trust policy below ensures that only a specific GitHub repository and branch can assume this role.

# For this to work, the GitHub Actions workflow must include:
#
# permissions:
#   id-token: write
#   contents: read
#
# And use the 'aws-actions/configure-aws-credentials' action to authenticate with AWS.

resource "aws_iam_role" "apply_log_writer" {
  name = "github-apply-log-writer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:sub" = "repo:${var.repo_name}:ref:refs/heads/main"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "s3_put_only" {
  name = "apply-log-s3-put-only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "arn:aws:s3:::terraform-apply-logs/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_put" {
  role       = aws_iam_role.apply_log_writer.name
  policy_arn = aws_iam_policy.s3_put_only.arn
}


