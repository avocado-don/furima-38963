FactoryBot.define do
  factory :item do
    Faker::Config.locale = :ja

    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    ship_fee_id { Faker::Number.between(from: 1, to: 2) }
    ship_day_id { Faker::Number.between(from: 1, to: 3) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
