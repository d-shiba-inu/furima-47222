FactoryBot.define do
  factory :user do
    nickname              { 'furima太郎' }
    email                 { Faker::Internet.unique.email }
    password              { '1a2b3c' }
    password_confirmation { password }
    lastname_full_letters { '山田' }
    firstname_full_letters { '太郎' }
    lastname_kana         { 'ヤマダ' }
    firstname_kana        { 'タロウ' }
    birth_date            { '1930-01-01' }
  end
end
