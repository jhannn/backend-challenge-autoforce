class Order < ApplicationRecord
    has_and_belongs_to_many :batches

    validates :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items, :status, presence: true, allow_blank: false
end
