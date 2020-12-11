FactoryBot.define do
  factory :item do
    name { Faker::Name.initials }
    explanation { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 10) }        # id=1は"--"
    item_status_id { Faker::Number.between(from: 2, to: 7) }      # id=1は"--"
    delivery_fee_id { Faker::Number.between(from: 2, to: 3) }     # id=1は"--"
    shipment_source_id { Faker::Number.between(from: 2, to: 48) } # id=1は"--"
    shipping_days_id { Faker::Number.between(from: 2, to: 4) }    # id=1は"--"
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
