FactoryBot.define do
  factory :purchase_address do
    post_code { '000-0000' }
    prefecture_code_id { Faker::Number.between(from: 2, to: 48) }
    address_city { '東京都' }
    address_street  { '000' }
    building_number { '000' }
    phone_number { '00000000000' }
    token { 'tok_abcdefghijk00000000000000000' }
    user_id { '1' }
    item_id { '1' }
  end
end
