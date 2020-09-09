FactoryBot.define do
  factory :favourite do
    user_id { User.first.id || association(:user) }
    house_id { House.first.id || association(:house) }
  end
end