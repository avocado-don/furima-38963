FactoryBot.define do
  factory :order_address do
    Faker::Config.locale = :ja

    token { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
    post_code { Faker::Address.postcode }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_num { "0#{Faker::Number.between(from: 100000000, to: 9999999999)}" }
  end
end
