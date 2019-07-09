Faker::Config.locale = 'pt-BR'
FactoryBot.define do
    factory :order do
        reference {Faker::Code.asin}
        purchase_channel {Faker::Internet.url}
        client_name {Faker::Name.name}
        address {Faker::Address.full_address}
        delivery_service {Faker::Company.name}
        total_value {Faker::Number.normal(5)}
        line_items {[{"sku": "case-my-best-friend", "model": "iPhone X", "case type": "Rose Leather"}, {"sku": "powebank-sunshine", "capacity": "10000mah"}, {"sku": "earphone-standard", "color": "white"}]}
        status {'ready'}
    end
end