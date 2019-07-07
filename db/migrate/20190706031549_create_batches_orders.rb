class CreateBatchesOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :batches_orders do |t|
      t.references :batch, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
