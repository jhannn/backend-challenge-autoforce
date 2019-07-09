Faker::Config.locale = 'pt-BR'
FactoryBot.define do
    factory :batch do
        reference {Faker::Code.asin}
        purchase_channel {Faker::Internet.url}
        orders {[build(:order)]}
    end
end