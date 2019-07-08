json.array! @batches do |batch|
    json.id batch.id
    json.reference batch.reference
    json.purchase_channel batch.purchase_channel
    json.orders batch.orders do |order|
        json.reference order.reference
        json.status order.status
    end
  end