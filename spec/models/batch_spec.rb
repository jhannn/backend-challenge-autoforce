require 'rails_helper'

RSpec.describe Batch, type: :model do
  let(:batch) {build(:batch)}

  describe 'validations in model attributes' do
    it {expect(batch).to respond_to(:reference)}
    it {expect(batch).to respond_to(:purchase_channel)}
    it {expect(batch).to respond_to(:orders)}
    it {expect(batch).to be_valid}
    it {expect(batch.orders.length).to eq 1}
    it {expect(batch.orders[0].reference).to_not be_nil}
  end
  
  # describe 'associations' do
  #   it {should has_and_belongs_to_many(:orders)}
  # end
  
  describe 'validations presence and blank' do
    it {should validate_presence_of(:reference)}
    it {should validate_presence_of(:purchase_channel)}
    it {should validate_presence_of(:orders)}
    it {should_not allow_value("", nil).for(:reference)}
    it {should_not allow_value("", nil).for(:purchase_channel)}
    it {should_not allow_value([]).for(:orders)}
  end

  describe 'validations' do
    # it {should validate_uniqueness_of(:reference).case_insensitive}
  end
end
