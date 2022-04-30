Role.create(name: 'admin') #id = 1
Role.create(name: 'worker') #id = 2
Role.create(name: 'normal') #id = 3

user1 = User.create(email: 'test@admin.com',
					password: 'qwerty123',
					password_confirmation: 'qwerty123')
user1.add_role(:admin)
user2 = User.create(email: 'test@worker.com',
					password: 'qwerty123',
					password_confirmation: 'qwerty123')
user2.add_role(:worker)
user2 = User.create(email: 'test@normal.com',
					password: 'qwerty123',
					password_confirmation: 'qwerty123')
user2.add_role(:normal)

# 1.upto(5) do |i|
# 	Book.create(title: "Book #{i}", author: "Author #{i}", description: "A sample book", pages: i*10, published: "2018-#{i}-10")
# end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# if Doorkeeper::Application.count.zero?
#     Doorkeeper::Application.create(name: "iOS client", redirect_uri: "", scopes: "")
#     Doorkeeper::Application.create(name: "Android client", redirect_uri: "", scopes: "")
#     Doorkeeper::Application.create(name: "React", redirect_uri: "", scopes: "")
# end