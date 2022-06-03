#Network configuration
# Providing a reference to our default VPC
resource "aws_default_vpc" "default_vpc" {
}

# Providing a reference to our default subnets
resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "us-west-2a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "us-west-2b"
}


#Adjusting service to reference the default subnets
resource "aws_ecs_service" "sample-app-nodejs-service" {
  name            = "sample-app-nodejs-service"
  cluster         = "${aws_ecs_cluster.sample-app-nodjs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.sample-app-nodejs-task.arn}"
  launch_type     = "EC2"
  desired_count   = 1

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = false
  }
}
