class Order < ApplicationRecord
    has_and_belongs_to_many :batches
    validates :reference, presence: true, allow_blank: false, uniqueness: true
    validates :client_name, :address, :delivery_service, :line_items, :status, presence: true, allow_blank: false
    validates :purchase_channel, presence: true, url: { allow_blank: false, public_suffix: true }
    validates :total_value, presence: true, numericality: true, allow_blank: false
    before_save :downcase_fields

    def downcase_fields
        self.purchase_channel.downcase!
        self.client_name.downcase!
        self.address.downcase!
        self.delivery_service.downcase!
        self.status.downcase!
    end
end
