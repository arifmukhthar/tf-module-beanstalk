resource "aws_route53_record" "r53_service_endpoint_record" {
  zone_id = data.aws_route53_zone.r53_user_managed_hosted_zone.zone_id
  name    = var.service_endpoint_url
  type    = "A"

  alias {
    name                   = aws_elastic_beanstalk_environment.beanstalk_environment.cname
    zone_id                = data.aws_elastic_beanstalk_hosted_zone.r53_aws_managed_beanstalk_hosted_zone.id
    evaluate_target_health = false
  }
}