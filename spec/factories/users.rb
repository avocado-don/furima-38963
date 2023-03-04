FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }

    Faker::Config.locale = :ja

    nickname { Faker::Lorem.word }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_kana { 'カナ' }
    first_kana { 'カタ' }

    birth { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
