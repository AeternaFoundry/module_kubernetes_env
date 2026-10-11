resource "kubernetes_env" "envs" {
  for_each = var.envs

  api_version    = each.value.api_version
  kind           = each.value.kind
  container      = each.value.container
  field_manager  = each.value.field_manager
  force          = each.value.force
  init_container = each.value.init_container

  dynamic "env" {
    for_each = each.value.env
    content {
      name  = env.value.name
      value = env.value.value
      dynamic "value_from" {
        for_each = env.value.value_from != null ? [env.value.value_from] : []
        content {
          dynamic "config_map_key_ref" {
            for_each = value_from.value.config_map_key_ref != null ? [value_from.value.config_map_key_ref] : []
            content {
              key      = config_map_key_ref.value.key
              name     = config_map_key_ref.value.name
              optional = config_map_key_ref.value.optional
            }
          }
          dynamic "field_ref" {
            for_each = value_from.value.field_ref != null ? [value_from.value.field_ref] : []
            content {
              api_version = field_ref.value.api_version
              field_path  = field_ref.value.field_path
            }
          }
          dynamic "resource_field_ref" {
            for_each = value_from.value.resource_field_ref != null ? [value_from.value.resource_field_ref] : []
            content {
              container_name = resource_field_ref.value.container_name
              divisor        = resource_field_ref.value.divisor
              resource       = resource_field_ref.value.resource
            }
          }
          dynamic "secret_key_ref" {
            for_each = value_from.value.secret_key_ref != null ? [value_from.value.secret_key_ref] : []
            content {
              key      = secret_key_ref.value.key
              name     = secret_key_ref.value.name
              optional = secret_key_ref.value.optional
            }
          }
        }
      }
    }
  }

  metadata {
    name      = each.value.metadata.name
    namespace = each.value.metadata.namespace
  }
}

