FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { '123abc' }
    password_confirmation { password }
  end
end
