variable "asg_schedules" {
  description = "A map of all schedules to apply to the autoscaling groups."
  type        = map(object({
    min_size          = number,
    max_size          = number,
    desired_capacity  = number,
    recurrence        = string,
    asg_name          = list(string)
  }))
  default     = {}
}
