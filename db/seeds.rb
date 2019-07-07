# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

batch = Batch.create({reference: '201803-54', purchase_channel: 'netshoes.com.br'})

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
        total_value: Faker::Number.decimal(5, 2),
        line_items: line_items,
        status: 'ready'
    })
end

batch.orders.create(reference: 'BR102030', purchase_channel: 'netshoes.com.br', client_name: 'São Clênio', address: 'Av. Amintas Barros Nº 3700 - Torre Business, Sala 702 - Lagoa Nova CEP: 59075-250', delivery_service: 'SEDEX', total_value: '123.30', line_items: [], status: 'ready')