require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    # 正常な値の組み合わせを定義する
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
    end
  end
end
