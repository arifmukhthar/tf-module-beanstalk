# A default IAM Policy document with rules to allow access to S3, CW and SSM.
# This policy should be used by default on all microservices managed by Elastic Beanstalk. 
data "aws_iam_policy_document" "s3_cloudwatch_ssm_access_policy" {
  
  # S3 access
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "*",
    ]
  }

  #CloudWatch Access
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "*"
    ]
  }

  # SSM Access
  statement {
    effect = "Allow"
    actions = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "*",
    ]
  }
    
}

data "aws_iam_policy_document" "ec2_assume_allow" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
      "ec2.amazonaws.com"]
    }
  }
}

# Data resources to get the latest Docker Solution Stack running on Amazon Linux  
data "aws_elastic_beanstalk_solution_stack" "single_docker" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux 2018.03 (.*) running Docker (.*)"
  
}

# Data resoruce to get the latest Amazon Linux 2 AMI ID
data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["aws-elasticbeanstalk-amzn-2018.03.20.x86_64-docker-hvm-*"]
  }
}

# User managed R53 Hosted Zone
data "aws_route53_zone" "r53_user_managed_hosted_zone" {
  name         = var.service_endpoint_url
  private_zone = false
}

# AWS Managed R53 Hosted Zone of Beanstalk Environment
data "aws_elastic_beanstalk_hosted_zone" "r53_aws_managed_beanstalk_hosted_zone" {
  region = "us-east-1"
}
