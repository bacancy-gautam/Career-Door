# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.new(
  firstname: 'career',
  lastname: 'door',
  username: 'siteadmin',
  email: 'urmit.prajapati@bacancytechnology.com',
  contact: '+91-112 234 4450',
  password: 'Admin@careerdoor1',
  password_confirmation: 'Admin@careerdoor1'
)
admin.add_role :super_admin
admin.save