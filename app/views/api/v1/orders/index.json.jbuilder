json.array! @orders do |order|
  json.reference order.reference
  json.status order.status
  json.purchase_channel order.purchase_channel
  json.client_name order.client_name
  json.address order.address
  json.delivery_service order.delivery_service
  json.items order.line_items  
  json.total_value order.total_value
end