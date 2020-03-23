# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


CATEGORIES = [
  {name: 'Restaurante', name_plural: 'Restaurantes'},
  {name: 'Café', name_plural: 'Cafés' },
  {name: 'Museu', name_plural: 'Museus' },
  {name: 'Zoo', name_plural: 'Zoos' },
  {name: 'Cabeleireiro', name_plural: 'Cabeleireiros' },
  {name: 'Teatro', name_plural: 'Teatros' },
  {name: 'Cinema', name_plural: 'Cinemas' }
]

CATEGORIES.each do |c|
  Category.create!(c)
end