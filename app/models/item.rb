class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  has_one :order

  # ActiveHashのAssociation
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :shipping_duration

  # 空禁止
  validates :name, :introduce, :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_duration_id,
            :price, :user, :image, presence: true

  # 「---」禁止
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_duration_id,
            numericality: { other_than: 1, message: "can't be blank" }

  # 価格のバリデーション
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }
end
