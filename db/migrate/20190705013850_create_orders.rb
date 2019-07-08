class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :purchase_channel
      t.string :client_name
      t.text :address
      t.string :delivery_service
      t.float :total_value
      t.json :line_items, array: true
      t.string :status

      t.timestamps
    end
  end
end
