# Azure ServiceBus

This module is used to create Azure Service Bus—Cloud Messaging Service  in kyndryl environment, it is a cloud messaging system for connecting apps and devices across public and private clouds.it is fully managed enterprise message broker with message queues and publish-subscribe topics (in a namespace).

## Requirements

|Name|Version|
|----|-------|
|terraform|~> 1.3.0|

## Providers

|Name|Version|
|----|-------|
|azurerm|~> 3.33.0|

## Modules

|Name|Version|
|----|-------|
|regioncodes|0.0.2|

|Name|Version|
|----|-------|
|diagnosticsetting|0.0.3|

## Parameters

### Service Bus Namespace

Service Bus Namespace expected objects as shown below:

```json
service_bus = {
  sb1 = {
    application                          = "servicebus1"
    purpose                              = "testing"
    environment                          = "dev"
    location                             = "eastus"
    instance                             = "001"
    sku                                  = "Premium"
    resource_group                       = "ss-rg-dev"
    additional_tags                      = "{}"
    dataretention_tag                    = "2 Years"
    approval_required                    = false
    capacity                             = "4"
    default_message_ttl                  = "P10675199DT2H48M5.4775807S"
    enable_batched_operations            = false
    support_ordering                     = false
    auto_delete_on_idle                  = "P10675199DT2H48M5.4775807S"
    lock_duration                        = "PT1M"
    max_delivery_count                   = 10
    forward_to                           = ""
    forward_dead_lettered_messages_to    = ""
    requires_session                     = false
    dead_lettering_on_message_expiration = true
    enable_batched_operations            = false
    auto_delete_on_idle                  = "P10675199DT2H48M5.4775807S"
    send_auth_rule_name                  = "SendSharedAccessKey1"
    listen_auth_rule_name                = "ListenSharedAccessKey"
    auth_rule_name                       = "SendAndListenSharedAccessKey"
    private_endpoint                     = "pvtend-servicebus"
    external_resource_ids                = {}

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
    application                          = "servicebus2"
    purpose                              = "testing"
    environment                          = "dev"
    location                             = "eastus"
    instance                             = "001"
    sku                                  = "Premium"
    resource_group                       = "ss-rg-dev"
    additional_tags                      = "{}"
    dataretention_tag                    = "2 Years"
    approval_required                    = false
    capacity                             = "4"
    default_message_ttl                  = "P10675199DT2H48M5.4775807S"
    enable_batched_operations            = false
    support_ordering                     = false
    auto_delete_on_idle                  = "P10675199DT2H48M5.4775807S"
    lock_duration                        = "PT1M"
    max_delivery_count                   = 10
    forward_to                           = ""
    forward_dead_lettered_messages_to    = ""
    requires_session                     = false
    dead_lettering_on_message_expiration = true
    enable_batched_operations            = false
    auto_delete_on_idle                  = "P10675199DT2H48M5.4775807S"
    send_auth_rule_name                  = "SendSharedAccessKey1"
    listen_auth_rule_name                = "ListenSharedAccessKey"
    auth_rule_name                       = "SendAndListenSharedAccessKey"
    private_endpoint                     = "pvtend-servicebus"
    external_resource_ids                = {}

    diagnostic_setting = {
      retention_policy_enabled       = false
      log_category                   = ["OperationalLogs", "VNetAndIPFilteringLogs", "RuntimeAuditLogs", "ApplicationMetricsLogs"]
      metric_category                = ["AllMetrics"]
      storage_account_id             = "/subscriptions/096b022c-90fa-4661-894b-1a47402b4cf6/resourceGroups/ss-rg-dev/providers/Microsoft.Storage/storageAccounts/datalaketestingdeveus001"
      eventhub_authorization_rule_id = "/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-network-dev-ops-eus/providers/Microsoft.EventHub/namespaces/newtestevhb/authorizationRules/RootManageSharedAccessKey"
      log_analytics_workspace_id     = "/subscriptions/7cf071f7-970a-4aa1-b847-5a123ff9a3ea/resourceGroups/rg-log-workspace-dev-eus/providers/Microsoft.OperationalInsights/workspaces/log-dev-eus"
    }
  }
}
```

### Service Bus Queue

Service Bus Queue expected objects as shown below:

```json
sb_queue_data = {
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
    }
  }
```

### Service Bus Topic

Service Bus Topic expected objects as shown below:

```json
 sb_topic_data = {
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
    }
  }
```

## Inputs

|Name|Description|Type|Default|Required|
|----|-----------|----|-------|--------|
| application | Application Name to create resource group name. | `string` | n/a | yes |
| purpose | Purpose of this resource group. | `string` | null | no |
| environment | Environment of this resource group. Acceptable values are `dev`, `testqa`, and `prod`.  | `string` | n/a | yes |
| location | Azure region of this resource group. | `string` | n/a | yes |
| instance | Instance number of this resource group. | `string` | n/a | no |
| dataretention_tag | Data retention tag. Example values: `7 Days`, `2 Months`, `1 Year`, `2 Years`, `5 Years`, `20 Years` | `string` | `n/a` | no |
| additional_tags | Map of additional tags of the Storage Account in addition to the mandatory resource tags | `map(string)` | `{}` | no |
|target_resource_id|The ID of an existing Resource on which to configure Diagnostic Settings.|string|n/a|yes|
|log_analytics_workspace_id|Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent|n/a|yes|
|enabled_content|Diagnostic Log enabled|bool|true|yes|
|retention_policy_enabled|....|bool|false|yes
|metric_category|The name of a Diagnostic Metric Category for this Resource|list(string)|AllMetrics|yes|
|log_category|The name of a Diagnostic Log Category for this Resource|list(string)|n/a|yes|
|eventhub_authorization_rule_id|Specifies the ID of a event hub where Diagnostics Data should be sent|string|n/a|yes|
|storage_account_id|Specifies the ID of a storage a/c where Diagnostics Data should be sent|string|n/a|yes|
|sku|Defines which tier to use|string|Options are `Basic`, `Standard` or `Premium`|Yes|
|capacity| Specifies the capacity|number|available options are: When sku is `Premium`, capacity can be `1`, `2`, `4`, `8` or `16`. When `sku` is `Basic` or `Standard`, capacity can be `0` only|No|
|redundancy|Whether or not this resource is zone redundan|bool|`sku` needs to be `Premium`. Defaults to false|No|
|name|Specifies the name of the ServiceBus Queue resource|String|n/a| Yes|
|lock_duration|The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers|string|Maximum value is `5` minutes. Defaults to `1` minute `PT1M`|No|
|max_delivery_count| Integer value which controls when a message is automatically dead lettered|number|10|No|
|requires_duplicate_detection|Boolean flag which controls whether the Queue requires duplicate detection|bool|false|No|
|duplicate_detection_history_time_window|he ISO 8601 timespan duration during which duplicates can be detected|string|Defaults to `10` (`PT10M`)|No|
|requires_session|Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages|bool|false|No|
|max_size_in_megabytes|nteger value which controls the size of memory allocated for the queue|number|1024|No|
|default_message_ttl|The ISO 8601 timespan duration of the TTL of messages sent to this queue. This is the default value used when TTL is not set on message itself.|string|"P10675199DT2H48M5.4775807S"|No|
|dead_lettering_on_message_expiration|Boolean flag which controls whether the Queue has dead letter support when a message expires|bool|false|No|
|auto_delete_on_idle|The ISO 8601 timespan duration of the idle interval after which the Queue is automatically deleted, minimum of 5 minutes|string|"P10675199DT2H48M5.4775807S"|No|
|enable_partitioning|Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers|bool|false|No|
|enable_express|Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage|bool|Defaults to `false` for`Basic` and `Standard`. For `Premium`, it MUST be set to false|No|
|send_auth_rule_name|This is the name of queue authorization rule|string|n/a|Yes|
|listen_auth_rule_name|queue authorization listern rule|string|n/a|Yes|
|support_ordering|Boolean flag which controls whether the Topic supports ordering|bool|false|No|
| forward_to|forwarding feature enables you to chain a queue or subscription to another queue or topic that is part of the same namespace.|number|n/a|No|

## Output

|Name|Description|Type|
|----|-----------|----|
| name | Service Bus name  | `string` |
| id | ServiceBus Id  | `string` |