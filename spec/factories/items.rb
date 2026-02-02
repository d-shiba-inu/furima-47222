FactoryBot.define do
  factory :item do
    name                   { 'オムライス' }
    introduce              { '美味しいオムライスです。' }
    category_id            { 2 }
    condition_id           { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id          { 2 }
    shipping_duration_id   { 2 }
    price                  { 1000 }

    association :user

    # 画像の設定（Active Storage）
    # 実行前に public/images/test_image.png を用意してね！
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
