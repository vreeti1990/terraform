# DevOps Assignment

## Introduction

This architecture consists of web servers running on apache application in which we have added redirects in the configuration file to redirects traffic to our S3 static website endpoint.

I have created this architecture in Terraform and it contains the following files:
#### s3.tf
Created this bucket including public access hosting static assets.
#### alb.tf
Application load balancer to route traffic to backend instances in multiple Availability Zone.
#### asg.tf: 
Created ASG (Auto Scaling group) to make the stack highly available and added ELB health check to launch a new server in case of application failure. Autoscaling also two policies enabled to track CPU usage and will take action based on the threshold defined.
#### launch-template.tf: 
Created this launch template to provide a configuration in case of a new server launch in the Autoscaling group.
#### rds.tf
Relational database.
#### main.tf
Defined aws provider and aws profile to use to create the infrastructure
#### userdata.sh:
Userdata script to install required dependencies like apache,PHP and copying apache redirect configuration file and database connectivity file like `dbinfo.inc` and `SamplePage.php`. 
#### vpc.tf: 
Created this template to create VPC, subnets, and its dependencies. I have used the terraform provided VPC module registry path so it creates by default all the resources required to create a VPC.
#### data.tf:
Data file to extract responses from other resources.

## Execution

To create this infrastructure we need to change two variables in the main.tf files and execute the code.
* Replace your profile name with your AWS profile
* Replace region if you have any preference to use(default is us-west-2 in this project).

## Access
To access the static assets, we need to grep the DNS name of the ALB created by terraform template and try to access it from a browser.

http://ALB DNS NAME/

To test database connectivity from apache server to mysql database:

http://ALB DNS NAME/SamplePage.php
