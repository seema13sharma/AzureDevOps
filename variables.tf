variable "service_bus" {
  type = map(object({
    application       = string
    purpose           = optional(string, "")
    environment       = string
    location          = string
    instance          = optional(string, "")
    resource_group    = string
    sku               = optional(string ,"Standard")
    additional_tags   = optional(map(string), {})
    dataretention_tag = optional(string)
    capacity          = optional(number, 0)
    redundancy        = optional(bool, false)

    diagnostic_setting = object({
      metric_category                = optional(list(string),["AllMetrics"])
      log_category                   = optional(list(string),[])
      storage_account_id             = optional(string)
      eventhub_authorization_rule_id = optional(string)
      log_analytics_workspace_id     = optional(string)
      retention_policy_enabled       = optional(bool, false)
    })
  }))
  description = "Bus Map"
}

variable "queues" {
  type = map(object({
    name                                    = string
    namespace_key                           = string
    lock_duration                           = optional(string, "PT1M")
    max_delivery_count                      = optional(number, 10)
    requires_duplicate_detection            = optional(bool, false)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    requires_session                        = optional(bool, false)
    max_size_in_megabytes                   = optional(number, 1024)
    default_message_ttl                     = optional(string, "P10675199DT2H48M5.4775807S")
    dead_lettering_on_message_expiration    = optional(bool, true)
    auto_delete_on_idle                     = optional(string, "P10675199DT2H48M5.4775807S")
    enable_partitioning                     = optional(bool, false)
    enable_express                          = optional(bool, false)
    send_auth_rule_name                     = string
    listen_auth_rule_name                   = string
  }))
  description = "Queues Map"
  default     = {}
}

variable "topics" {
  type = map(object({
    name                                    = string
    namespace_key                           = string
    lock_duration                           = optional(string, "PT1M")
    max_delivery_count                      = optional(number, 10)
    forward_to                              = optional(string, "")
    forward_dead_lettered_messages_to       = optional(string, "")
    requires_session                        = optional(bool, false)
    dead_lettering_on_message_expiration    = optional(bool, true)
    enable_batched_operations               = optional(bool, false)
    default_message_ttl                     = optional(string, "P10675199DT2H48M5.4775807S")
    auto_delete_on_idle                     = optional(string, "P10675199DT2H48M5.4775807S")
    max_size_in_megabytes                   = optional(number, 1024)
    requires_duplicate_detection            = optional(bool, false)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    support_ordering                        = optional(bool, false)
    enable_express                          = optional(bool, false)
    enable_partitioning                     = optional(bool, false)
    auth_rule_name                          = string
  }))
  description = "Topic Map"
  default     = {}
}
