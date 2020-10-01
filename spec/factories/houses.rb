# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    name { Faker::Lorem.words(number: 4) }
    description { Faker::Lorem.paragraph(sentence_count: 10) }
    image_url { Faker::Placeholdit.image }
    price { Faker::Number.decimal(l_digits: 5) }
  end
end
