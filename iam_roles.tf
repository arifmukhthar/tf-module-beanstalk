# This resources creates an IAM role with in-line policy to access S3, CW and SSM
resource "aws_iam_role_policy" "s3_cloudwatch_access_policy" {
  name   = "${var.bc_env}-${var.bc_app_name}"
  role   = aws_iam_role.beanstalk_iam_role.id
  policy = data.aws_iam_policy_document.s3_cloudwatch_ssm_access_policy.json
}

# This resource attaches an assume policy to the same IAM role
resource "aws_iam_role" "beanstalk_iam_role" {
  name               = "${var.bc_env}-${var.bc_app_name}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_allow.json
  tags               = local.all_tags
}

# This resources creates an instance profile and attaches the IAM role created above for the Beanstalk's EC2 instances to assume.
resource "aws_iam_instance_profile" "beanstalk_instance_profile" {
  name = "${var.bc_env}-${var.bc_app_name}"
  role = aws_iam_role.beanstalk_iam_role.name
}