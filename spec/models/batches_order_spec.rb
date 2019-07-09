require 'rails_helper'

RSpec.describe BatchesOrder, type: :model do
  it { should belong_to(:batch) }
  it { should belong_to(:order) }
end
