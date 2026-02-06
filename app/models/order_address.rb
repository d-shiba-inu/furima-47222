class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  validates :postal_code, :prefecture_id, :city, :street_address, :phone_number, :user_id, :item_id, :token,
            presence: true
end
