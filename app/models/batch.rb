class Batch < ApplicationRecord
  has_many :orders, dependent: :destroy
end