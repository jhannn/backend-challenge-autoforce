Faker::Config.locale = 'pt-BR'
FactoryBot.define do
    factory :batch do
        reference {Faker::Code.unique.asin}
        purchase_channel {Faker::Internet.url}
        orders {[build(:order, status:'production')]}
    end
end