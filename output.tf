output "servicebus" {
  description = "The output map for the created Service bus"
  value = {
    for k, v in azurerm_servicebus_namespace.sb : k => {
      name = v.name
      id   = v.id
    }
  }
}