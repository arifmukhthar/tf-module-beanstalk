locals {

  suffix   = "${var.bc_env}-${var.bc_app_name}"
  ec2_name = "${var.component_name}-${local.suffix}"
  all_tags = merge(
    {
      "bounded_context" = var.bc_name
      "Name"            = local.ec2_name
      "env"             = var.bc_env
    },
    var.bc_vpc_generic_tags,
    var.bc_vpc_defined_tags
  )
}

resource "aws_elastic_beanstalk_environment" "beanstalk_environment" {
  name                = "${var.bc_app_name}-${var.bc_env}"
  application         = var.bc_app_name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.single_docker.id
  # tags                = local.all_tags

  dynamic "setting" {
    for_each = local.network_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.elb_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.instance_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.autoscaling_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.healthcheck_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.notification_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = local.deployment_settings
    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  dynamic "setting" {
    for_each = var.beanstalk_environment_variables
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
    }
}
}