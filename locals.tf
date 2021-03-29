locals {
  temp_routes  = {
    for k, v in var.static_routes : k => merge(
      v,
    )
  }
  static_routes = [for k, v in local.temp_routes : v]
}
