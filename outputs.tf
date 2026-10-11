output "envs_id" {
  description = "Map of id values across all envs, keyed the same as var.envs except keys with no id are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.id if v.id != null && length(v.id) > 0 }
}
output "envs_api_version" {
  description = "Map of api_version values across all envs, keyed the same as var.envs except keys with no api_version are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.api_version if v.api_version != null && length(v.api_version) > 0 }
}
output "envs_container" {
  description = "Map of container values across all envs, keyed the same as var.envs except keys with no container are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.container if v.container != null && length(v.container) > 0 }
}
output "envs_env" {
  description = "Map of env values across all envs, keyed the same as var.envs except keys with no env are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.env if v.env != null && length(v.env) > 0 }
}
output "envs_field_manager" {
  description = "Map of field_manager values across all envs, keyed the same as var.envs except keys with no field_manager are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.field_manager if v.field_manager != null && length(v.field_manager) > 0 }
}
output "envs_force" {
  description = "Map of force values across all envs, keyed the same as var.envs except keys with no force are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.force if v.force != null }
}
output "envs_init_container" {
  description = "Map of init_container values across all envs, keyed the same as var.envs except keys with no init_container are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.init_container if v.init_container != null && length(v.init_container) > 0 }
}
output "envs_kind" {
  description = "Map of kind values across all envs, keyed the same as var.envs except keys with no kind are omitted"
  value       = { for k, v in kubernetes_env.envs : k => v.kind if v.kind != null && length(v.kind) > 0 }
}
output "envs_metadata" {
  description = "Map of metadata values across all envs, keyed the same as var.envs except keys with no metadata are omitted"
  value       = { for k, v in kubernetes_env.envs : k => one(v.metadata) if v.metadata != null && length(v.metadata) > 0 }
}

