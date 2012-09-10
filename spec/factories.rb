require 'faker'

FactoryGirl.define do
  
  factory :pic do
    title Faker::Name.first_name
    image File.open('spec/support/sample_photo.jpg')
  end

  factory :user do
    email Faker::Internet.email
    password "secret"
  end
end