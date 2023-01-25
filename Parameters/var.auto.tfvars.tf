service_bus = {
  sb1 = {
    application       = "servicebus1"
    purpose           = "testing"
    environment       = "dev"
    location          = "eastus"
    instance          = "001"
    sku               = "Premium"
    resource_group    = "ss-rg-dev"
    additional_tags   = {}
    dataretention_tag = "2 Years"
    capacity          = "4"
    redundancy        = true

    diagnostic_setting = {
      retention_policy_enabled       = false
      log_category                   = ["OperationalLogs", "VNetAndIPFilteringLogs", "RuntimeAuditLogs", "ApplicationMetricsLogs"]
      metric_category                = ["AllMetrics"]
      storage_account_id             = "/subscriptions/096b022c-90fa-4661-894b-1a47402b4cf6/resourceGroups/ss-rg-dev/providers/Microsoft.Storage/storageAccounts/datalaketestingdeveus001"
      eventhub_authorization_rule_id = "/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-network-dev-ops-eus/providers/Microsoft.EventHub/namespaces/newtestevhb/authorizationRules/RootManageSharedAccessKey"
      log_analytics_workspace_id     = "/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-log-workspace-dev-eus/providers/Microsoft.OperationalInsights/workspaces/log-dev-eus"
    }
  },
  sb2 = {
    application       = "servicebus2"
    purpose           = "testing"
    environment       = "dev"
    location          = "eastus"
    instance          = "001"
    sku               = "Premium"
    resource_group    = "ss-rg-dev"
    additional_tags   = {}
    dataretention_tag = "2 Years"
    capacity          = "4"
    redundancy        = true

    diagnostic_setting = {
      retention_policy_enabled       = false
      log_category                   = ["OperationalLogs", "VNetAndIPFilteringLogs", "RuntimeAuditLogs", "ApplicationMetricsLogs"]
      metric_category                = ["AllMetrics"]
      storage_account_id             = null #"/subscriptions/096b022c-90fa-4661-894b-1a47402b4cf6/resourceGroups/ss-rg-dev/providers/Microsoft.Storage/storageAccounts/datalaketestingdeveus001"
      eventhub_authorization_rule_id = "/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-network-dev-ops-eus/providers/Microsoft.EventHub/namespaces/newtestevhb/authorizationRules/RootManageSharedAccessKey"
      log_analytics_workspace_id     = null #"/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-log-workspace-dev-eus/providers/Microsoft.OperationalInsights/workspaces/log-dev-eus"
    }
  }
}

queues = {
  queue1 = {
    name                                    = "queue1"
    namespace_key                           = "sb1"
    lock_duration                           = "PT1M"
    max_delivery_count                      = 10
    requires_duplicate_detection            = false
    duplicate_detection_history_time_window = "PT10M"
    requires_session                        = false
    max_size_in_megabytes                   = 1024
    default_message_ttl                     = "P10675199DT2H48M5.4775807S"
    dead_lettering_on_message_expiration    = true
    auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
    enable_partitioning                     = false
    enable_express                          = false
    send_auth_rule_name                     = "SendSharedAccessKey1"
    listen_auth_rule_name                   = "ListenSharedAccessKey"
  },
  queue2 = {
    name                                    = "queue2"
    namespace_key                           = "sb2"
    lock_duration                           = "PT1M"
    max_delivery_count                      = 10
    requires_duplicate_detection            = false
    duplicate_detection_history_time_window = "PT10M"
    requires_session                        = false
    max_size_in_megabytes                   = 1024
    default_message_ttl                     = "P10675199DT2H48M5.4775807S"
    dead_lettering_on_message_expiration    = true
    auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
    enable_partitioning                     = false
    enable_express                          = false
    send_auth_rule_name                     = "SendSharedAccessKey2"
    listen_auth_rule_name                   = "ListenSharedAccessKey"
  }
}

topics = {
  topic1 = {
    name                                    = "topic1"
    namespace_key                           = "sb1"
    lock_duration                           = "PT1M"
    max_delivery_count                      = 10
    forward_to                              = ""
    forward_dead_lettered_messages_to       = ""
    requires_session                        = false
    dead_lettering_on_message_expiration    = true
    enable_batched_operations               = false
    default_message_ttl                     = "P10675199DT2H48M5.4775807S"
    auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
    enable_partitioning                     = false
    max_size_in_megabytes                   = 1024
    requires_duplicate_detection            = false
    duplicate_detection_history_time_window = "PT10M"
    support_ordering                        = false
    enable_express                          = false
    auth_rule_name                          = "SendAndListenSharedAccessKey1"
  },
  topic2 = {
    name                                    = "topic2"
    namespace_key                           = "sb2"
    lock_duration                           = "PT1M"
    max_delivery_count                      = 10
    forward_to                              = ""
    forward_dead_lettered_messages_to       = ""
    requires_session                        = false
    dead_lettering_on_message_expiration    = true
    enable_batched_operations               = false
    default_message_ttl                     = "P10675199DT2H48M5.4775807S"
    auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
    enable_partitioning                     = false
    max_size_in_megabytes                   = 1024
    requires_duplicate_detection            = false
    duplicate_detection_history_time_window = "PT10M"
    support_ordering                        = false
    enable_express                          = false
    auth_rule_name                          = "SendAndListenSharedAccessKey2"
  }
}
