module "tags_sb" {
  source        = "app.terraform.io/Kyndryl-CIO/resourcetags/azurerm"
  version       = "0.1.0"
  for_each      = var.service_bus
  DataRetention = each.value.dataretention_tag
}

module "regioncodes" {
  source  = "app.terraform.io/Kyndryl-CIO/regioncodes/azurerm"
  version = "0.0.2"
}

locals {
  sb_name_map = { for k, v in var.service_bus :
    k => "${v["application"]}${v["purpose"]}${v["environment"]}${module.regioncodes.region_codes[lower(replace(v["location"], " ", ""))]}${v.instance == "" ? "" : "${v.instance}"}"
  }
}

resource "azurerm_servicebus_namespace" "sb" {
  for_each            = var.service_bus
  name                = local.sb_name_map[each.key]
  location            = each.value.location
  resource_group_name = each.value.resource_group
  sku                 = each.value.sku
  capacity            = each.value.sku == "Premium" ? each.value.capacity : 0
  zone_redundant      = each.value.sku == "Premium" ? each.value.redundancy : false
  tags                = merge(module.tags_sb[each.key].tags, each.value.additional_tags)

  lifecycle {
    ignore_changes = [
      tags["DeployDate"]
    ]
  }
}

resource "azurerm_servicebus_queue" "sbq" {
  for_each                                = var.queues
  name                                    = each.value.name
  namespace_id                            = lookup(azurerm_servicebus_namespace.sb, each.value.namespace_key)["id"]
  lock_duration                           = each.value.lock_duration
  max_delivery_count                      = each.value.max_delivery_count
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  requires_session                        = each.value.requires_session
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  default_message_ttl                     = each.value.default_message_ttl
  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  enable_partitioning                     = each.value.enable_partitioning
  enable_express                          = each.value.enable_express
}

resource "azurerm_servicebus_queue_authorization_rule" "send_auth_rule" {
  for_each = var.queues
  name     = each.value.send_auth_rule_name
  queue_id = lookup(azurerm_servicebus_queue.sbq, each.key)["id"]
  send     = true
}

resource "azurerm_servicebus_queue_authorization_rule" "listen_auth_rule" {
  for_each = var.queues
  name     = each.value.listen_auth_rule_name
  queue_id = lookup(azurerm_servicebus_queue.sbq, each.key)["id"]
  listen   = true
}

resource "azurerm_servicebus_topic" "sbt" {
  for_each                                = var.topics
  name                                    = each.value.name
  namespace_id                            = lookup(azurerm_servicebus_namespace.sb, each.value.namespace_key)["id"]
  enable_partitioning                     = each.value.enable_partitioning
  default_message_ttl                     = each.value.default_message_ttl
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  enable_batched_operations               = each.value.enable_batched_operations
  support_ordering                        = each.value.support_ordering
  auto_delete_on_idle                     = each.value.auto_delete_on_idle
  enable_express                          = each.value.enable_express
}

resource "azurerm_servicebus_topic_authorization_rule" "send_listen_auth_rule" {
  for_each = var.topics
  name     = each.value.auth_rule_name
  topic_id = lookup(azurerm_servicebus_topic.sbt, each.key)["id"]
  listen   = true
  send     = true
}

resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  for_each                             = var.topics
  name                                 = each.value.name
  topic_id                             = lookup(azurerm_servicebus_topic.sbt, each.key)["id"]
  lock_duration                        = each.value.lock_duration
  max_delivery_count                   = each.value.max_delivery_count
  forward_to                           = each.value.forward_to
  forward_dead_lettered_messages_to    = each.value.forward_dead_lettered_messages_to
  requires_session                     = each.value.requires_session
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
  enable_batched_operations            = each.value.enable_batched_operations
  default_message_ttl                  = each.value.default_message_ttl
  auto_delete_on_idle                  = each.value.auto_delete_on_idle
}

# Diagnostic Setting
module "diagnostic_setting_servicebus" {
  for_each = var.service_bus
  source   = "app.terraform.io/Kyndryl-CIO/diagnosticsetting/azurerm"
  version  = "~> 0.0.7"

  diagnostic_setting = {
    ds1 = {
      application                    = each.value.application
      purpose                        = each.value.purpose
      environment                    = each.value.environment
      location                       = each.value.location
      instance                       = each.value.instance
      target_resource_id             = "${lookup(azurerm_servicebus_namespace.sb, each.key)["id"]}"
      enabled_content                = true
      retention_policy_enabled       = coalesce(lookup(each.value.diagnostic_setting, "retention_policy_enabled"), false)
      metric_category                = each.value.diagnostic_setting.metric_category
      log_category                   = each.value.diagnostic_setting.log_category
      storage_account_id             = each.value.diagnostic_setting.storage_account_id
      eventhub_authorization_rule_id = each.value.diagnostic_setting.eventhub_authorization_rule_id
      log_analytics_workspace_id     = each.value.diagnostic_setting.log_analytics_workspace_id
    }
  }
}