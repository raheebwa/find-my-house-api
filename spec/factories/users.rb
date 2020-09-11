# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    password { 'password' }
  end
end
