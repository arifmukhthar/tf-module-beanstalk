# Elastic Beanstalk Environment

<br/>

# Prerequisites
Before executing module the following are expected to exist:
* A VPC
* One or more Private subnets
* One or more Public subnets

<br/>

# Expectations
This module will create a single Beanstalk Application (if it doesn't exisist already) and a complete Beanstalk Environment.  
* 1 Elastic Beanstalk Application
* 1 Elastic Beanstalk Environment (includes the components provisioned by the Managed service)
* 2 IAM Policy documents
* 2 Security Groups
* 1 IAM Role
* 1 IAM Instance Profile
* 1 ACM Certificate
* 1 ACM Certificate validation DNS record in R53
* 1 Alias Record in R53 pointing to Beanstalk environment's CNAME

All you need to do is provide the *Required Inputs* (elucidated in the next section). You can also decalre the *Optional Inputs* to tweak the Beanstalk environment to suite your application's needs. 

<br/>

# Required Inputs

## bc_name
No default. This module cannot be consumed without setting it. <br/>
Example: `student_activity`

## bc_env
No default.
 -  Used with `bc_name` to set the prefix for all naming of resources. Experimental variable validation has been activated to ensure this is one of `dev`, `prod`, or `staging`.
 - Used with `bc_app_name` to generate the Beanstalk Environment name during the environment creation. 
 <br/>
Example: `staging`

## component
No default. Used with creating unique names to allow multiple vpc in same account with different cidr blocks.
<br/>
Example: `bff`

## bc_app_name
No default. 
 - This is the microservice's name and is needed in the module. This name is used as the Elastic Beanstalk Application name. 
 - Used with `bc_env` to generate the Beanstalk Environment name during the environment creation. 
<br/>
 Example: `content-service`

## vpc_id
No default. This is the VPC ID where the Elastic Beanstalk needs to be provisioned.
<br/>
Example: `"vpc-xxxxxxx"`

## ec2_subnet_id
No default. This is where Beanstalk provisions its EC2 instance and NEEDS to be **Private Subnet IDs**. Provide input as list of strings. 
<br/>
Example: `["subnet-xxxxxxx", "subnet-yyyyy"]`

## elb_subnet_id
No default. This is where Beanstalk provisions its Load Balancer and NEEDS to be **Public Subnet IDs**. Provide input as list of strings.
<br/>
Example: `["subnet-xxxxxxx", "subnet-yyyyy"]`

## application_healthcheck_url
No default. This is the URL path which beanstalk pings for performing healthcheck on the applcation. 
<br/>
Example: `/actuator/health`

<br/>

## service_endpoint_url
No default. The desired service endpoint (FQDN) in the format <env>.<service-name>.savvasrealize.com.
<br/>
Example: `staging.mylibrary-service.savvasrealize.com`

<br/>

# Optional Inputs

Although this section is descriptive enough, all the *Parameters* each Input here supports is not outlined in this document. These are the 'Option settings' Beanstalk  provides to tweak the environment to suit your applications needs. Comprehensive documentation on all the Inputs (or `Options` in AWS lingo) given below can be found [here](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html).

## elb_scheme
Default is `Public`.  This is to specify if the application's Load Balancer needs to be internet facing or to only recieve requests internal to the VPC.

## elb_cross_zone_enabled
Default is `true`. If set to true, the load balancer will route traffic evenly across all instances in all Availability Zones rather than only within each zone.

## elb_listener_protocol
Default is `HTTPS`. When a listener is attached to the ELB, it needs a protocal. This variable sets the protocol used by the listener.

## elb_listener_instance_port
Default is `80`. This is the port that the ELB's listener uses to communicate with the backend server. (This is the port the application runs on)

## elb_listener_instance_protocol
Default is `HTTP`. The protocol that this listener uses to communicate with the EC2 instances. It must be at the same internet protocol layer as the ListenerProtocol.

## elb_connection_idle_timeout
Default is `60`. ELB's connection Idle timeout in seconds.

## elb_connection_draining
Default is `false`. Set to true if Connection Draining needs to be enabled in the ELB.

## elb_stickiness_policy
Default is `false`. If set to true, binds a user's session to a specific server instance so that all requests coming from the user during the session are sent to the same server instance.

## elb_sticky_cookie_expiration_time
Default is `0`. The amount of time, in seconds, that each cookie is valid. Uses the default policy (AWSEB-ELB-StickinessPolicy).

## instance_type
Default is `t2.micro`. Instance Type for the the EC2 instances spawned by Beanstalk. \

## ec2_root_volume_size
Default is `50`. The size of the storage (EBS root volume) to attach to each EC2 instance.

## autoscaling_nodes_max
Default is `1`. The maximum number of nodes the Autoscaling Group can have.

## autoscaling_nodes_min
Default is `1`. The minimum number of nodes the Autoscaling Group can have.

## autoscaling_cooldown_period
Default is `360`. The amount of time, in seconds, after a scaling activity completes before another scaling activity can start.

## autoscaling_trigger_metric
Default is `CPUUtilization`. This metric monitored and based on this autoscaling events are triggered.

## autoscaling_trigger_metric_unit
Default is `Percent`. Unit for the trigger measurement.

## autoscaling_trigger_metric_statistic
Default is `Average`. "Unit for the trigger measurement. 

## autoscaling_trigger_upper_threshold
Default is `40`. Upper threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system surpasses this limit.

## autoscaling_trigger_lower_threshold
Default is `20`. Lower threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system drops below this limit.

## autoscaling_trigger_lower_threshold
Default is `20`. Lower threshold limit for the autoscaling trigger metric. Autoscaling events are triggered once the system drops below this limit.

## autoscaling_trigger_period
Default is `1`. Specifies how frequently Amazon CloudWatch measures the metrics for your trigger. The value is the number of minutes between two consecutive periods.

## autoscaling_trigger_evaluation_period
Default is `1`. The number of consecutive evaluation periods used to determine if a breach is occurring.

## autoscaling_trigger_breach_duration
Default is `1`. Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires.

## autoscaling_trigger_node_increment
Default is `1`. Number of EC2 instances to add when performing a scaling activity.

## autoscaling_trigger_node_decrement
Default is `-1`. Number of EC2 instances to remove when performing a scaling activity.

## deployment_policy
Default is `Rolling`. Specify the kind of deployment Beanstalk has to do when deploying new packages to the beanstalk environment

## deplyoment_rolling_update
Default is `true`. If true, enables rolling updates for an environment.

## deployment_rolling_update_type
Default is `Health`.Time-based rolling updates apply a PauseTime between batches. Health-based rolling updates wait for new instances to pass health checks before moving on to the next batch. Immutable updates launch a full set of instances in a new Auto Scaling group.

## deployment_batch_size_type
Default is `Percentage`.The type of number that is specified in deployment_batch_size. Example: If deployment_batch_size is 30 and deployment_batch_size_type is Percentage, then 30% of nodes deployed in each batch during a deployment

## deployment_batch_size
Default is `30`. Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments.

## deployment_pause_time
Default is `PT4M30S`. The default has been set to 4mins 30secs. The amount of time the Elastic Beanstalk service will wait after it has completed updates to one batch of instances before it continues on to the next batch.

## deployment_timeout
Default is `600`. Number of seconds to wait for an instance to complete executing commands. By default Beanstalk adds 240 seconds to the time defined here.

## ec2_availability_zones
Default is `Any`. AZs across which the EC2 your instances.

## notification_email
Default is `sptrealizealerts@savvas.com`. Beanstalk related alerts are sent to this Email ID.

## healthcheck_healthy_threshold
Default is `3`. Consecutive successful healthchecks before ELB can mark the instance as healthy.

## healthcheck_unhealthy_threshold
Default is `5`. Consecutive unsuccessful healthchecks before ELB can mark the instance as unhealthy.

## healthcheck_timeout
Default is `5`. Number of seconds ELB will wait for a response before it considers the instance nonresponsive.

## healthcheck_interval
Default is `6`. The interval (in seconds) at which ELB will check the health of your application's Amazon EC2 instances.

## datadog_api_key
Default is Realize dev environment's Datadog API key. This **NEEDS** to be overriden for the production environment. 

<br/>

# Things to Note:
* Environment Name and Application name should be defined as Beanstalk's Environment Variable (this is taken care internally by the module itself). This is needed in Datadog configuration files to define the datadog service name. This is just an FYI, you don't have to do anything here.

* Beanstalk automatically creates  Security Groups (*Managed security Groups*) and attaches them to ELB and EC2. Note that we also create two security groups in our module to attach to ELB and EC2. We create two separate Security Groups (and define our own rules) in the module because terraform doesn't have a way to modify the *Managed Security Groups*.

* The module has a default *IAM Policy* which gives the EC2 instances access to Cloudwatch, S3 and SSM. The *IAM Instance profile* for the Beanstalk Environment is created based off this policy. At the moment, the only way to add new policy (like access to RDS or DynamoDB) to the *Instance Profile* to access other AWS services, is to attach new policies to the profile manually from the console. The *IAM Instance Profile*  name would be `${var.bc_env}-${var.bc_app_name}`, you will need to look this up in the AWS IAM Console and attach policies directly. 

<br/>

# Todo list:
* IAM Dynamic policy generation based on IAM Policy Statements specified as variables during module consumption. 

* Create CW metrics at the ELB level for 5xx, 4xx and Latency as a part of the module itself.  
