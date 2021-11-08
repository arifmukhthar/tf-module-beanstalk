# ARN of the Resources created or used in this Module
output "beanstalk_environment_arn" {
  description = "ARN of the Beanstalk Environment"
  value       = aws_elastic_beanstalk_environment.beanstalk_environment.arn
}

output "beanstalk_ec2_sg_arn" {
  description = "ARN of the Beanstalk Environment"
  value       = aws_security_group.ec2_sg.arn
}

output "beanstalk_elb_sg_arn" {
  description = "ARN of the Beanstalk Environment"
  value       = aws_security_group.elb_sg.arn
}

output "ami_id_arn" {
  description = "ARN of the AMI used"
  value       = data.aws_ami.amazon_linux_2.arn
}

output "beanstalk_iam_role_arn" {
  description = "IAM Role created to attach to Beanstalk's IAM instance profile"
  value       = aws_iam_role.beanstalk_iam_role.arn
}

output "beanstalk_iam_instance_profile_arn" {
  description = "IAM Role created to attach to Beanstalk's IAM instance profile"
  value       = aws_iam_instance_profile.beanstalk_instance_profile.arn
}


# Name of the Resources created and Settings used in this Module

output "bc_region" {
  description = "Name of the Beanstalk Application"
  value       = var.bc_region
}

output "bc_env" {
  description = "Name of the Beanstalk Application"
  value       = var.bc_env
}

output "bc_app_name" {
  description = "Name of the Beanstalk Application"
  value       = var.bc_app_name
}

output "component_name" {
  description = "Name of the component"
  value        = var.component_name
}

output "beanstalk_app_name" {
  description = "Name of the Beanstalk Application"
  value       = var.bc_app_name
}

output "beanstalk_environment_name" {
  description = "ARN of the Beanstalk Environment"
  value       = aws_elastic_beanstalk_environment.beanstalk_environment.name
}

output "solution_stack_name" {
  description = "Solution stack NAme"
  value       = data.aws_elastic_beanstalk_solution_stack.single_docker.id
}

output "beanstalk_iam_policy_name" {
  description = "IAM Role created to attach to Beanstalk's IAM instance profile"
  value       = aws_iam_role_policy.s3_cloudwatch_access_policy.name
}


output "vpc_id" {
  description = "VPC ID where Beanstalk components reside in"
  value       = var.vpc_id
}

output "elb_subnet_id" {
  description = "VPC ID where Beanstalk components reside in"
  value       = var.ec2_subnet_id

}

output "ec2_subnet_id" {
  description = "VPC ID where Beanstalk components reside in"
  value       = var.elb_subnet_id

}

output "beanstalk_elb_sg_name" {
  description = "Public subnet ID Beanstalk Environment"
  value       = aws_security_group.elb_sg.name
}

output "beanstalk_ec2_sg_name" {
  description = "Private Subnet ID of the Beanstalk Environment"
  value       = aws_security_group.ec2_sg.name
}

output "elb_scheme" {

  description = "Specify if the application's Load Balancer needs to be public facing or to only recieve requests internal to the VPC"
  value       = var.elb_scheme
}

output "elb_cross_zone_enabled" {

  description = "If set to true, the load balancer will route traffic evenly across all instances in all Availability Zones rather than only within each zone."
  value       = var.elb_cross_zone_enabled

}

output "elb_listener_protocol" {

  description = "The protocol used by the listener."
  value       = var.elb_listener_protocol
}

output "elb_listener_instance_port" {

  description = "The port that this listener uses to communicate with the EC2 instances."
  value       = var.elb_listener_instance_port
}

output "elb_listener_instance_protocol" {

  description = "The protocol that this listener uses to communicate with the EC2 instances. It must be at the same internet protocol layer as the ListenerProtocol"
  value       = var.elb_listener_instance_protocol
}

# output "acm_ssl_certificate_arn" {
#   description = "Existing SSL Certificate to attach to the ELB. The module creates an SSL certificate and attaches it to the ELB managed by Beanstalk"
#   value       = aws_acm_certificate.acm_certificate
# }

# output "acm_ssl_certificate_r53_validation" {
#   description = "ACM SSL Certificate Verification DNS record created in R53 user managed hosted zone"
#   value       = aws_acm_certificate_validation.acm_certificate_validation
# }

output "elb_connection_idle_timeout" {

  description = "ELB's connection Idle timeout in seconds"
  value       = var.elb_connection_idle_timeout
}

output "elb_connection_draining" {

  description = "Set to true if Connection Draining needs to be enabled in the ELB"
  value       = var.elb_connection_draining
}

output "elb_connection_draining_timeout" {

  description = "Time taken before stopping connection draining at ELB level"
  value       = var.elb_connection_draining_timeout
}

output "elb_stickiness_policy" {

  description = "If set to true, binds a user's session to a specific server instance so that all requests coming from the user during the session are sent to the same server instance."
  value       = var.elb_stickiness_policy
}

output "elb_sticky_cookie_expiration_time" {

  description = "The amount of time, in seconds, that each cookie is valid. Uses the value policy (AWSEB-ELB-StickinessPolicy)."
  value       = var.elb_sticky_cookie_expiration_time
}

output "instance_type" {

  description = "Instance Type of the EC2 Instance managed by Beanstalk"
  value       = var.elb_sticky_cookie_expiration_time
}

output "ec2_root_volume_size" {

  description = "The size of the storage (EBS root volume) to attach to each EC2 instance"
  value       = var.ec2_root_volume_size
}

output "ec2_root_volume_type" {

  description = "Volume type (magnetic, general purpose SSD or provisioned IOPS SSD) to use for the root Amazon EBS volume attached to your environment's EC2 instances."
  value       = var.ec2_root_volume_type
}

output "autoscaling_nodes_max" {

  description = "Maximum number of nodes the Autoscaling Group can have."
  value       = var.autoscaling_nodes_max
}

output "autoscaling_nodes_min" {

  description = "Minimum number of nodes the Autoscaling Group can have"
  value       = var.autoscaling_nodes_min
}

output "autoscaling_cooldown_period" {

  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  value       = var.autoscaling_cooldown_period
}

output "autoscaling_trigger_metric" {

  description = "This metric monitored and based on this autoscaling events are triggered"
  value       = var.autoscaling_trigger_metric
}

output "autoscaling_trigger_metric_unit" {

  description = "Unit for the trigger measurement"
  value       = var.autoscaling_trigger_metric_unit
}

output "autoscaling_trigger_metric_statistic" {

  description = "Unit for the trigger measurement. Example: Average"
  value       = var.autoscaling_trigger_metric_statistic
}

output "autoscaling_trigger_upper_threshold" {

  description = "Upper threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system surpasses this limit."
  value       = var.autoscaling_trigger_upper_threshold
}

output "autoscaling_trigger_lower_threshold" {

  description = "Lower threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system drops below this limit."
  value       = var.autoscaling_trigger_lower_threshold
}

output "autoscaling_trigger_period" {

  description = "Specifies how frequently Amazon CloudWatch measures the metrics for your trigger. The value is the number of minutes between two consecutive periods."
  value       = var.autoscaling_trigger_period
}

output "autoscaling_trigger_evaluation_period" {

  description = "The number of consecutive evaluation periods used to determine if a breach is occurring."
  value       = var.autoscaling_trigger_evaluation_period
}

output "autoscaling_trigger_breach_duration" {

  description = "Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires."
  value       = var.autoscaling_trigger_breach_duration
}

output "autoscaling_trigger_node_increment" {

  description = "Number of EC2 instances to add when performing a scaling activity."
  value       = var.autoscaling_trigger_node_increment
}

output "autoscaling_trigger_node_decrement" {

  description = "Number of EC2 instances to remove when performing a scaling activity."
  value       = var.autoscaling_trigger_node_decrement
}

output "deployment_policy" {

  description = "The kind of deployment Beanstalk has to do when deploying new packages to the beanstalk environment"
  value       = var.deployment_policy
}

output "deplyoment_rolling_update" {

  description = "If true, enables rolling updates for an environment."
  value       = var.deplyoment_rolling_update
}

output "deployment_rolling_update_type" {

  description = "Time-based rolling updates apply a PauseTime between batches. Health-based rolling updates wait for new instances to pass health checks before moving on to the next batch. Immutable updates launch a full set of instances in a new Auto Scaling group."
  value       = var.deployment_rolling_update_type
}

output "deployment_batch_size_type" {

  description = "The type of number that is specified in deployment_batch_size. Example: If deployment_batch_size is 30 and deployment_batch_size_type is Percentage, then 30% of nodes deployed in each batch during a deployment"
  value       = var.deployment_batch_size_type
}

output "deployment_batch_size" {

  description = "Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments."
  value       = var.deployment_batch_size
}

output "deployment_pause_time" {

  description = "The amount of time the Elastic Beanstalk service will wait after it has completed updates to one batch of instances before it continues on to the next batch."
  value       = var.deployment_pause_time
}

output "deployment_timeout" {

  description = "Number of seconds to wait for an instance to complete executing commands. By value Beanstalk adds 240 seconds to the time defined here."
  value       = var.deployment_timeout
}

output "ec2_availability_zones" {

  description = "Number of AZs across which the EC2 your instances"
  value       = var.ec2_availability_zones
}


output "notification_email" {

  description = "Beanstalk related alerts are sent to this Email ID."
  value       = var.notification_email
}

output "application_healthcheck_url" {
  description = "This path is used by Beanstalk's ELB to do healthchecks on the application"
  value       = var.application_healthcheck_url
}

output "healthcheck_healthy_threshold" {

  description = "Consecutive successful healthchecks before ELB can mark the instance as healthy."
  value       = var.healthcheck_healthy_threshold
}

output "healthcheck_unhealthy_threshold" {

  description = "Consecutive successful healthchecks before ELB can mark the instance as healthy."
  value       = var.healthcheck_unhealthy_threshold
}

output "healthcheck_timeout" {

  description = "Number of seconds ELB will wait for a response before it considers the instance nonresponsive."
  value       = var.healthcheck_timeout
}

output "healthcheck_interval" {

  description = "The interval (in seconds) at which ELB will check the health of your application's Amazon EC2 instances."
  value       = var.healthcheck_interval
}

output "r53_service_endpoint_record" {
  description = "The R53 record created in user managed AWS acc to redirect traffic to Beanstalk Environment's CNAME"
  value       = aws_route53_record.r53_service_endpoint_record
}