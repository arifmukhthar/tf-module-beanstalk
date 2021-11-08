locals {
  network_settings = [
    {
      name      = "VPCId"
      namespace = "aws:ec2:vpc"
      value     = var.vpc_id
    },
    {
      name      = "Subnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", sort(var.ec2_subnet_id))
    },
    {
      name      = "ELBSubnets"
      namespace = "aws:ec2:vpc"
      value     = join(",", sort(var.elb_subnet_id))
    },
    {
      name      = "SecurityGroups"
      namespace = "aws:elb:loadbalancer"
      value     = aws_security_group.elb_sg.id
    },
    {
      name      = "SecurityGroups"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = aws_security_group.ec2_sg.id
    },
  ]

  elb_settings = [
    {
      name      = "ELBScheme",
      namespace = "aws:ec2:vpc",
      value     = var.elb_scheme
    },
    {
      name      = "CrossZone"
      namespace = "aws:elb:loadbalancer"
      value     = var.elb_cross_zone_enabled
    },
    # {
    #   name      = "ListenerProtocol"
    #   namespace = "aws:elb:listener:443"
    #   value     = var.elb_listener_protocol
    # },
    # {
    #   name      = "InstancePort"
    #   namespace = "aws:elb:listener:443"
    #   value     = var.elb_listener_instance_port
    # },
    # {
    #   name      = "InstanceProtocol"
    #   namespace = "aws:elb:listener:443"
    #   value     = var.elb_listener_instance_protocol
    # },
    # {
    #   name      = "ListenerEnabled"
    #   namespace = "aws:elb:listener:443"
    #   value     = "true"
    # },
    # {
    #   namespace = "aws:elb:listener:443"
    #   name      = "SSLCertificateId"
    #   value     = aws_acm_certificate.acm_certificate.arn
    # },
    {
      namespace = "aws:elb:policies"
      name      = "ConnectionSettingIdleTimeout"
      value     = var.elb_connection_idle_timeout
    },
    {
      namespace = "aws:elb:policies"
      name      = "ConnectionDrainingEnabled"
      value     = var.elb_connection_draining
    },
    {
      name      = "ConnectionDrainingTimeout"
      namespace = "aws:elb:policies"
      value     = var.elb_connection_draining_timeout
    },
    {
      name      = "Stickiness Policy",
      namespace = "aws:elb:policies",
      value     = var.elb_stickiness_policy
    },
    {
      name      = "Stickiness Cookie Expiration",
      namespace = "aws:elb:policies",
      value     = var.elb_sticky_cookie_expiration_time
    },
  ]

  instance_settings = [
    {
      name      = "InstanceType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.instance_type
    },
    {
      name      = "ImageId"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = data.aws_ami.amazon_linux_2.id
    },
    {
      name      = "IamInstanceProfile"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = aws_iam_instance_profile.beanstalk_instance_profile.name
    },
    {
      name      = "RootVolumeSize"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.ec2_root_volume_size
    },
    {
      name      = "RootVolumeType"
      namespace = "aws:autoscaling:launchconfiguration"
      value     = var.ec2_root_volume_type
    }
  ]

  autoscaling_settings = [
    {
      name      = "MaxSize"
      namespace = "aws:autoscaling:asg"
      value     = var.autoscaling_nodes_max
    },
    {
      name      = "MinSize"
      namespace = "aws:autoscaling:asg"
      value     = var.autoscaling_nodes_min
    },
    {
      name      = "Cooldown"
      namespace = "aws:autoscaling:asg"
      value     = var.autoscaling_cooldown_period
    },
    {
      name      = "Availability Zones"
      namespace = "aws:autoscaling:asg"
      value     = var.ec2_availability_zones
    },
    {
      name      = "MeasureName"
      namespace = "aws:autoscaling:trigger"
      value     = var.autoscaling_trigger_metric
    },
    {
      name      = "Unit"
      namespace = "aws:autoscaling:trigger"
      value     = var.autoscaling_trigger_metric_unit
    },
    {
      name      = "Statistic",
      namespace = "aws:autoscaling:trigger"
      value     = var.autoscaling_trigger_metric_statistic
    },
    {
      name      = "UpperThreshold",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_upper_threshold
    },
    {
      name      = "LowerThreshold",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_lower_threshold
    },
    {
      name      = "Period",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_period
    },
    {
      name      = "EvaluationPeriods",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_evaluation_period
    },
    {
      name      = "BreachDuration",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_breach_duration
    },
    {
      name      = "UpperBreachScaleIncrement"
      namespace = "aws:autoscaling:trigger"
      value     = var.autoscaling_trigger_node_increment
    },
    {
      name      = "LowerBreachScaleIncrement",
      namespace = "aws:autoscaling:trigger",
      value     = var.autoscaling_trigger_node_decrement
    },
  ]

  healthcheck_settings = [
    {
      name      = "Application Healthcheck URL"
      namespace = "aws:elasticbeanstalk:application"
      value     = var.application_healthcheck_url
    },
    {
      name      = "HealthyThreshold"
      namespace = "aws:elb:healthcheck"
      value     = var.healthcheck_healthy_threshold
    },
    {
      name      = "UnhealthyThreshold"
      namespace = "aws:elb:healthcheck"
      value     = var.healthcheck_unhealthy_threshold
    },
    {
      name      = "Timeout"
      namespace = "aws:elb:healthcheck"
      value     = var.healthcheck_timeout
    },
    {
      name      = "Interval"
      namespace = "aws:elb:healthcheck"
      value     = var.healthcheck_interval
    },
  ]

  notification_settings = [
    {
      name      = "Notification Endpoint"
      namespace = "aws:elasticbeanstalk:sns:topics"
      value     = var.notification_email
    },
  ]

  deployment_settings = [

    {
      name      = "DeploymentPolicy"
      namespace = "aws:elasticbeanstalk:command",
      value     = var.deployment_policy
    },
    {
      name      = "RollingUpdateEnabled"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate",
      value     = var.deplyoment_rolling_update
    },
    {
      name      = "RollingUpdateType"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate",
      value     = var.deployment_rolling_update_type
    },
    {
      name      = "BatchSizeType"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_batch_size_type
    },
    {
      name      = "BatchSize"
      namespace = "aws:elasticbeanstalk:command"
      value     = var.deployment_batch_size
    },
    {
      name      = "PauseTime"
      namespace = "aws:autoscaling:updatepolicy:rollingupdate",
      value     = var.deployment_pause_time
    },
    {
      name      = "Timeout",
      namespace = "aws:elasticbeanstalk:command",
      value     = var.deployment_timeout
    }
  ]
}