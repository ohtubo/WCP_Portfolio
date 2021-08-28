# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'AAAAAA',
  self_introduction: '初めまして、[AAAAAA]です。最近投稿始めました。よろしくお願いします。',
  icon_image: File.open('./app/assets/images/user1.jpg'),
  email: 'brte14020@gmail.com',
  password: 'aa123456aa',
  password_confirmation: 'aa123456aa'
)

User.create!(
  name: 'BBBBBB',
  self_introduction: '初めまして、[BBBBBB]です。最近投稿始めました。よろしくお願いします。',
  icon_image: File.open('./app/assets/images/user2.jpg'),
  email: 'zt2bd8e8nizsgwrnvk93@docomo.ne.jp',
  password: 'bb123456bb',
  password_confirmation: 'bb123456bb'
)

User.create!(
  name: 'CCCCCC',
  self_introduction: '初めまして、[CCCCCC]です。最近投稿始めました。よろしくお願いします。',
  icon_image: File.open('./app/assets/images/user3.jpg'),
  email: 'breakblue3476@gmail.com',
  password: 'cc123456cc',
  password_confirmation: 'cc123456cc'
)

# CSVファイルを使用することを明示
require 'csv'

# 使用するデータ（CSVファイルの列）を指定
# /scenario/-------------------------------------------
CSVROW_USERID = 0
CSVROW_TITLE = 1
CSVROW_OVERVIEW = 2
# CSVROW_SCENARIO_IMAGE = 3
CSVROW_SYSTEM_CATEGORY = 3
CSVROW_UPPER_LIMIT_COUNT = 4
CSVROW_LOWER_LIMIT_COUNT = 5
CSVROW_PLAY_GENRE = 6
CSVROW_PLAY_TIME = 7
CSVROW_CONTENT = 8
CSVROW_LEVEL = 9
CSVROW_CREATED_AT = 10
CSVROW_UPDATED_AT = 11
num = 0
#/tag/-------------------------------------------------------
CSVROW_TAG = 0

#/scenario_tags/-------------------------------------------------------
CSVROW_SCENARIO_ID = 0
CSVROW_TAG_ID = 1

CSV.foreach('db/csv/scenario.csv', headers: true) do |row|

  if num > 4
    num = 0
  end
  Scenario.create(
    user_id: row[CSVROW_USERID],
    title: row[CSVROW_TITLE],
    overview: row[CSVROW_OVERVIEW],
    system_category: row[CSVROW_SYSTEM_CATEGORY],
    scenario_image: File.open("./app/assets/images/scenario_#{num}.jpg"),
    upper_limit_count: row[CSVROW_UPPER_LIMIT_COUNT],
    lower_limit_count: row[CSVROW_LOWER_LIMIT_COUNT],
    play_genre: row[CSVROW_PLAY_GENRE],
    play_time: row[CSVROW_PLAY_TIME],
    content: row[CSVROW_CONTENT],
    level: row[CSVROW_LEVEL],
    created_at: row[CSVROW_CREATED_AT],
    updated_at: row[CSVROW_UPDATED_AT]
  )

  num += 1
end

CSV.foreach('db/csv/tag.csv', headers: true) do |row|
  Tag.create(
    tag: row[CSVROW_TAG]
  )
end

CSV.foreach('db/csv/scenario_tags.csv', headers: true) do |row|
  ScenarioTag.create(
    scenario_id: row[CSVROW_SCENARIO_ID],
    tag_id: row[CSVROW_TAG_ID]
  )
end