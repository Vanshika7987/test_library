# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create({

                     name: 'Vanshika',
                     role: 'student',
                     phone_number: '8349074537'
                   })
library = Library.create({
                           name: 'xyz',
                           address: 'indore',
                           librarian_id: 8
                         })
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?