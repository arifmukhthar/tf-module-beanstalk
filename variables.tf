variable "bc_region" {
  description = "Region of the Bounded Context"
  type        = string
  default     = "us-east-1"
}

variable "bc_env" {
  description = "Env. dev, staging, prod"
  type        = string
  validation {
    condition = contains(
      [
        "dev",
        "nightly",
        "staging",
        "prod"
      ],
      var.bc_env
    )
    error_message = "Bad environment name. bc_env must be one of (dev|nightly|prod|staging)."
  }
}

variable "bc_name" {
  description = "Name of the Bounded Context, used in string building"
  type        = string
}

variable "bc_app_name" {
  description = "Name of the Service, used in string building"
  type        = string
}

variable "component_name" {
  description = "Name of the component"
  type        = string
}

variable "bc_vpc_generic_tags" {
  description = "Generic tags to be applied to all taggable resources in the VPC. For internal use."
  type        = map
  default = {
    "terraform_managed" = "True"
  }
}

# Intentionally left blank, to be used by code that includes this module
variable "bc_vpc_defined_tags" {
  description = "Tags specific to the Bounded Context, to be applied to all taggable resources in the VPC"
  type        = map
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the Beanstalk needs to be provisioned."
}

variable "ec2_subnet_id" {
  type        = list(string)
  description = "Private Subnet IDs where EC2 instances are provisioned. Provide input as list of strings"
}

variable "elb_subnet_id" {
  type        = list(string)
  description = "Public Subnet IDs where ELB is provisioned. Provide input as list of strings."
}

variable "elb_scheme" {
  type        = string
  description = "Specify if the application's Load Balancer needs to be public facing or to only recieve requests internal to the VPC"
  default     = "public"
}

variable "elb_cross_zone_enabled" {
  type        = string
  description = "If set to true, the load balancer will route traffic evenly across all instances in all Availability Zones rather than only within each zone."
  default     = "true"
}

variable "elb_listener_protocol" {
  type        = string
  description = "The protocol used by the listener."
  default     = "HTTPS"
}

variable "elb_listener_instance_port" {
  type        = string
  description = "The port that this listener uses to communicate with the EC2 instances."
  default     = "80"
}

variable "elb_listener_instance_protocol" {
  type        = string
  description = "The protocol that this listener uses to communicate with the EC2 instances. It must be at the same internet protocol layer as the ListenerProtocol"
  default     = "HTTP"
}

variable "service_endpoint_url" {
  type        = string
  description = "The desired service endpoint in the format <env>.<service-name>.savvasrealize.com. Ex. staging.mylibrary-service.savvasrealize.com"
}

variable "elb_connection_idle_timeout" {
  type        = string
  description = "ELB's connection Idle timeout in seconds"
  default     = "60"
}

variable "elb_connection_draining" {
  type        = string
  description = "Set to true if Connection Draining needs to be enabled in the ELB"
  default     = "false"
}

variable "elb_connection_draining_timeout" {
  type        = string
  description = "Time taken before stopping connection draining at ELB level"
  default     = "60"
}

variable "elb_stickiness_policy" {
  type        = string
  description = "If set to true, binds a user's session to a specific server instance so that all requests coming from the user during the session are sent to the same server instance."
  default     = "false"
}

variable "elb_sticky_cookie_expiration_time" {
  type        = string
  description = "The amount of time, in seconds, that each cookie is valid. Uses the default policy (AWSEB-ELB-StickinessPolicy)."
  default     = "0"
}

variable "instance_type" {
  type        = string
  description = "Instance Type for the the EC2 instances managed by Beanstalk"
  default     = "t2.micro"
}

variable "ec2_root_volume_size" {
  type        = string
  description = "The size of the storage (EBS root volume) to attach to each EC2 instance"
  default     = "50"
}

variable "ec2_root_volume_type" {
  type        = string
  description = "Volume type (magnetic, general purpose SSD or provisioned IOPS SSD) to use for the root Amazon EBS volume attached to your environment's EC2 instances."
  default     = "gp2"
}

# IAM profile is dynamically generated in the module itself with default permissions to access S3, CW and SSM. 
# This variable will be used when the module is enhanced to make use of existing IAM profiles.
# variable "iam_instance_profile" {
#   type        = string
#   description = "IAM instance profile to attach to to the EC2 instances"
# }

variable "autoscaling_nodes_max" {
  type        = string
  description = "Maximum number of nodes the Autoscaling Group can have."
  default     = "1"
}

variable "autoscaling_nodes_min" {
  type        = string
  description = "Minimum number of nodes the Autoscaling Group can have"
  default     = "1"
}

variable "autoscaling_cooldown_period" {
  type        = string
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = "360"
}

variable "autoscaling_trigger_metric" {
  type        = string
  description = "This metric monitored and based on this autoscaling events are triggered"
  default     = "CPUUtilization"
}

variable "autoscaling_trigger_metric_unit" {
  type        = string
  description = "Unit for the trigger measurement"
  default     = "Percent"
}

variable "autoscaling_trigger_metric_statistic" {
  type        = string
  description = "Unit for the trigger measurement. Example: Average"
  default     = "Average"
}

variable "autoscaling_trigger_upper_threshold" {
  type        = string
  description = "Upper threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system surpasses this limit."
  default     = "80"
}

variable "autoscaling_trigger_lower_threshold" {
  type        = string
  description = "Lower threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system drops below this limit."
  default     = "20"
}

variable "autoscaling_trigger_period" {
  type        = string
  description = "Specifies how frequently Amazon CloudWatch measures the metrics for your trigger. The value is the number of minutes between two consecutive periods."
  default     = "1"
}

variable "autoscaling_trigger_evaluation_period" {
  type        = string
  description = "The number of consecutive evaluation periods used to determine if a breach is occurring."
  default     = "1"
}

variable "autoscaling_trigger_breach_duration" {
  type        = string
  description = "Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires."
  default     = "1"
}

variable "autoscaling_trigger_node_increment" {
  type        = string
  description = "Number of EC2 instances to add when performing a scaling activity."
  default     = "1"
}

variable "autoscaling_trigger_node_decrement" {
  type        = string
  description = "Number of EC2 instances to remove when performing a scaling activity."
  default     = "-1"
}

variable "deployment_policy" {
  type        = string
  description = "Specify the kind of deployment Beanstalk has to do when deploying new packages to the beanstalk environment"
  default     = "Rolling"
}

variable "deplyoment_rolling_update" {
  type        = string
  description = "If true, enables rolling updates for an environment."
  default     = "true"
}

variable "deployment_rolling_update_type" {
  type        = string
  description = "Time-based rolling updates apply a PauseTime between batches. Health-based rolling updates wait for new instances to pass health checks before moving on to the next batch. Immutable updates launch a full set of instances in a new Auto Scaling group."
  default     = "Health"
}

variable "deployment_batch_size_type" {
  type        = string
  description = "The type of number that is specified in deployment_batch_size. Example: If deployment_batch_size is 30 and deployment_batch_size_type is Percentage, then 30% of nodes deployed in each batch during a deployment"
  default     = "Percentage"
}

variable "deployment_batch_size" {
  type        = string
  description = "Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments."
  default     = "30"
}

variable "deployment_pause_time" {
  type        = string
  description = "The amount of time the Elastic Beanstalk service will wait after it has completed updates to one batch of instances before it continues on to the next batch."
  default     = "PT4M30S"
}

variable "deployment_timeout" {
  type        = string
  description = "Number of seconds to wait for an instance to complete executing commands. By default Beanstalk adds 240 seconds to the time defined here."
  default     = "600"
}

variable "ec2_availability_zones" {
  type        = string
  description = "Number of AZs across which the EC2 your instances"
  default     = "Any"
}


variable "notification_email" {
  type        = string
  description = "Beanstalk related alerts are sent to this Email ID."
  default     = "sptrealizealerts@savvas.com"
}

variable "application_healthcheck_url" {
  type        = string
  description = "This path is used by Beanstalk's ELB to do healthchecks on the application"
}

variable "healthcheck_healthy_threshold" {
  type        = string
  description = "Consecutive successful healthchecks before ELB can mark the instance as healthy."
  default     = "3"
}

variable "healthcheck_unhealthy_threshold" {
  type        = string
  description = "Consecutive successful healthchecks before ELB can mark the instance as healthy."
  default     = "5"
}

variable "healthcheck_timeout" {
  type        = string
  description = "Number of seconds ELB will wait for a response before it considers the instance nonresponsive."
  default     = "5"
}

variable "healthcheck_interval" {
  type        = string
  description = "The interval (in seconds) at which ELB will check the health of your application's Amazon EC2 instances."
  default     = "6"
}

variable "beanstalk_environment_variables"{
  type        = map
  description = "Environment variables added to all EC2 instances managed by Elastic Beanstalk"
  default     = {
    ""=""
  }
}