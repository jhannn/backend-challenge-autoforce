json.array! @orders do |order|
    json.reference order.reference
    json.status order.status
    json.delivery_service order.delivery_service
    json.client_name order.client_name
    json.address order.address
    json.items order.line_items
    json.total_value order.total_value
  end