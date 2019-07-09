require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) {build(:order)}

  it {expect(order).to respond_to(:reference)}
  it {expect(order).to respond_to(:purchase_channel)}
  it {expect(order).to respond_to(:client_name)}
  it {expect(order).to respond_to(:address)}
  it {expect(order).to respond_to(:delivery_service)}
  it {expect(order).to respond_to(:total_value)}
  it {expect(order).to respond_to(:line_items)}
  it {expect(order).to respond_to(:status)}
  it {expect(order).to be_valid}
  
  # describe 'associations' do
  #   it {should has_and_belongs_to_many(:batches)}
  # end
  
  describe 'validations presence and blank' do
    it {should validate_presence_of(:reference)}
    it {should validate_presence_of(:purchase_channel)}
    it {should validate_presence_of(:client_name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:delivery_service)}
    it {should validate_presence_of(:total_value)}
    it {should validate_presence_of(:line_items)}
    it {should validate_presence_of(:status)}
    it {should_not allow_value("", nil).for(:reference)}
    it {should_not allow_value("", nil).for(:purchase_channel)}
    it {should_not allow_value("", nil).for(:client_name)}
    it {should_not allow_value("", nil).for(:address)}
    it {should_not allow_value("", nil).for(:delivery_service)}
    it {should_not allow_value("", nil).for(:total_value)}
    it {should_not allow_value("", nil).for(:line_items)}
    it {should_not allow_value("", nil).for(:status)}
  end

  describe 'validations' do
    # it {should validate_uniqueness_of(:reference).case_insensitive}
    it {should validate_numericality_of(:total_value)}
  end

end
