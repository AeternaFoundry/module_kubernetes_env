variable "envs" {
  description = <<EOT
Map of envs, attributes below
Required:
    - api_version
    - kind
    - env (block):
        - name (required)
        - value (optional)
        - value_from (optional, block):
            - config_map_key_ref (optional, block):
                - key (optional)
                - name (optional)
                - optional (optional)
            - field_ref (optional, block):
                - api_version (optional)
                - field_path (optional)
            - resource_field_ref (optional, block):
                - container_name (optional)
                - divisor (optional)
                - resource (required)
            - secret_key_ref (optional, block):
                - key (optional)
                - name (optional)
                - optional (optional)
    - metadata (block):
        - name (required)
        - namespace (optional)
Optional:
    - container
    - field_manager
    - force
    - init_container
EOT

  type = map(object({
    api_version    = string
    kind           = string
    container      = optional(string)
    field_manager  = optional(string)
    force          = optional(bool)
    init_container = optional(string)
    env = list(object({
      name  = string
      value = optional(string)
      value_from = optional(object({
        config_map_key_ref = optional(object({
          key      = optional(string)
          name     = optional(string)
          optional = optional(bool)
        }))
        field_ref = optional(object({
          api_version = optional(string)
          field_path  = optional(string)
        }))
        resource_field_ref = optional(object({
          container_name = optional(string)
          divisor        = optional(string)
          resource       = string
        }))
        secret_key_ref = optional(object({
          key      = optional(string)
          name     = optional(string)
          optional = optional(bool)
        }))
      }))
    }))
    metadata = object({
      name      = string
      namespace = optional(string)
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.envs : (
        length(v.env) >= 1
      )
    ])
    error_message = "Each env list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.envs : (
        v.container == null || (length(trimspace(v.container)) > 0)
      )
    ])
    error_message = "must not be empty or only whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.envs : (
        v.init_container == null || (length(trimspace(v.init_container)) > 0)
      )
    ])
    error_message = "must not be empty or only whitespace"
  }
  validation {
    condition = alltrue([
      for k, v in var.envs : (
        contains([for v in ["CronJob", "Deployment", "Pod", "DaemonSet", "replicationcontroller", "StatefulSet", "ReplicaSet"] : lower(v)], lower(v.kind))
      )
    ])
    error_message = "must be one of: \"CronJob\", \"Deployment\", \"Pod\", \"DaemonSet\", \"replicationcontroller\", \"StatefulSet\", \"ReplicaSet\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

