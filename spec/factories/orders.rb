Faker::Config.locale = 'pt-BR'
FactoryBot.define do
    factory :order do
        reference {Faker::Code.unique.asin}
        purchase_channel {Faker::Internet.url}
        client_name {Faker::Name.name}
        address {Faker::Address.full_address}
        delivery_service {Faker::Company.name}
        total_value {Faker::Number.decimal(l_digits: 4, r_digits: 2)}
        line_items {[{"sku": "case-my-best-friend", "model": "iPhone X", "case type": "Rose Leather"}, {"sku": "powebank-sunshine", "capacity": "10000mah"}, {"sku": "earphone-standard", "color": "white"}]}
    end
end