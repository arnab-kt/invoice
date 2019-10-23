# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{ name: 'Smart Phones', active: true }, { name: 'Laptops', active: true }])
Brand.create([{ name: 'MI', active: true }, { name: 'Dell', active: true }])
Uom.create([{ name: 'Piece', abbreviation: 'Pc', active: true }, { name: 'Kilograms', abbreviation: 'Kg',active: true }])