# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times  do
    line_items = []
    3.times  do
        line_items << {sku: Faker::Commerce.product_name, color: Faker::Commerce.color, material: Faker::Commerce.material}
    end    
	Order.create({
		reference: Faker::Code.asin,
        purchase_channel: Faker::Internet.url,
        client_name: Faker::Name.name,
        address: Faker::Address.full_address,
        delivery_service: Faker::Company.name,
        total_value: Faker::Number.decimal(2),
        line_items: line_items,
        status: Faker::Name.first_name
	})
end