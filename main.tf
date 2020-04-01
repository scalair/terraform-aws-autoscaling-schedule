locals {
  schedules = flatten([
    for schedule_key, schedule_value in var.asg_schedules: [
      for asg in schedule_value.asg_name: {
        autoscaling_group_name  = asg,
        scheduled_action_name   = schedule_key,
        min_size                = schedule_value.min_size,
        max_size                = schedule_value.max_size,
        desired_capacity        = schedule_value.desired_capacity,
        recurrence              = schedule_value.recurrence
      }
    ]
  ])
}

resource "aws_autoscaling_schedule" "schedule" {
  for_each = {
    for schedule in local.schedules : "${schedule.autoscaling_group_name}.${schedule.scheduled_action_name}" => schedule
  }

  autoscaling_group_name  = each.value.autoscaling_group_name
  scheduled_action_name   = each.value.scheduled_action_name
  min_size                = each.value.min_size
  max_size                = each.value.max_size
  desired_capacity        = each.value.desired_capacity
  recurrence              = each.value.recurrence
}
