require 'faker'

FactoryGirl.define do

  factory :user do
    email Faker::Internet.email
    password "secret"
  end

  factory :pic do
    title Faker::Name.first_name
    image File.open('spec/support/sample_photo.jpg')
  end

  factory :invalid_pic, :parent => :pic do
    title nil
  end
end