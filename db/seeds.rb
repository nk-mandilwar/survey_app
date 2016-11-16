# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

75.times do
  User.create(
    :username => SecureRandom.hex(6),
    :email => "#{SecureRandom.hex(6)}@ex.c",
    :password => "123123",
    :confirmed_at => Time.now
  )
end