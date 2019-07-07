class BatchesOrder < ApplicationRecord
  belongs_to :batch
  belongs_to :order
end
