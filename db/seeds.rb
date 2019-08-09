# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ranking.create(description: "Greatest in the Game!!!")

10.times do
    Player.create(name: Faker::Sports::Basketball.player, position: Faker::Sports::Basketball.position, number: Faker::Number.within(range: 1..50))
end