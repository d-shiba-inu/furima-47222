require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    FactoryBot.build(:user)
    FactoryBot.build(:item)
    @order_address = FactoryBot.build(:order_address, user_id: 1, item_id: 1)
  end

  describe '商品購入機能の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      # 郵便番号
      describe '郵便番号' do
        it 'postal_codeが空だと保存できない' do
          @order_address.postal_code = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'postal_codeが「3桁ハイフン4桁」の形式でないと保存できない' do
          @order_address.postal_code = '1234567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
        end
      end

      # 都道府県
      describe '都道府県' do
        it 'prefecture_idが空（nil）だと保存できない' do
          @order_address.prefecture_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'prefecture_idに「---」（id: 1）が選択されている場合は保存できない' do
          @order_address.prefecture_id = 1
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
        end
      end

      # 市区町村・番地
      describe '市区町村・番地' do
        it 'cityが空だと保存できない' do
          @order_address.city = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("City can't be blank")
        end
        it 'street_addressが空だと保存できない' do
          @order_address.street_address = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Street address can't be blank")
        end
      end

      # 電話番号
      describe '電話番号' do
        it 'phone_numberが空だと保存できない' do
          @order_address.phone_number = ''
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberが9桁以下では保存できない' do
          @order_address.phone_number = '090123456'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number is invalid')
        end
        it 'phone_numberが12桁以上では保存できない' do
          @order_address.phone_number = '090123456789'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number is invalid')
        end
        it 'phone_numberに半角数字以外が含まれている場合は保存できない' do
          @order_address.phone_number = '090-1234-5678'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number is invalid')
        end
      end

      # ユーザー・商品・トークン
      describe '取引関連' do
        it 'user_idが空だと保存できない' do
          @order_address.user_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("User can't be blank")
        end
        it 'item_idが空だと保存できない' do
          @order_address.item_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Item can't be blank")
        end
        it 'tokenが空だと保存できない' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end
