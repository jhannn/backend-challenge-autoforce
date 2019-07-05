class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.string :reference, unique: true
      t.string :purchase_channel
      t.references :orders, foreign_key: true

      t.timestamps
    end
  end
end
