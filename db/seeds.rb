# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "AAAAAA",
  self_introduction: "初めまして、[AAAAAA]です。最近投稿始めました。よろしくお願いします。",
  icon_image: File.open('./app/assets/images/user1.jpg'),
  email: "brte14020@gmail.com",
  password: "aa123456aa",
  password_confirmation: "aa123456aa"
)

User.create!(
  name: "BBBBBB",
  self_introduction: "初めまして、[BBBBBB]です。最近投稿始めました。よろしくお願いします。",
  icon_image: File.open('./app/assets/images/user2.jpg'),
  email: "zt2bd8e8nizsgwrnvk93@docomo.ne.jp",
  password: "bb123456bb",
  password_confirmation: "bb123456bb"
)

User.create!(
  name: "CCCCCC",
  self_introduction: "初めまして、[CCCCCC]です。最近投稿始めました。よろしくお願いします。",
  icon_image: File.open('./app/assets/images/user3.jpg'),
  email: "breakblue3476@gmail.com",
  password: "cc123456cc",
  password_confirmation: "cc123456cc"
)