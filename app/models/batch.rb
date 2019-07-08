class Batch < ApplicationRecord
  has_and_belongs_to_many :orders
  validates :reference, uniqueness: true
  validates :orders, presence: true, allow_blank: false
  validates :purchase_channel, presence: true, url: { allow_blank: false, public_suffix: true }
  before_save :downcase_fields

  def downcase_fields
    self.purchase_channel.downcase!
  end
end