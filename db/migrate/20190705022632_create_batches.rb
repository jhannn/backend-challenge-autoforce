class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.string :reference, unique: true
      t.string :purchase_channel

      t.timestamps
    end
  end
end
