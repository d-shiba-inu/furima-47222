require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      # Lesson6「ChatAppのモデル単体テストコードを書こう」にもある記述
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字以下では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      # Lesson6「ChatAppのモデル単体テストコードを書こう」にはない記述
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end

      it 'lastname_full_lettersが空では登録できない' do
        @user.lastname_full_letters = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname full letters can't be blank")
      end

      it 'firstname_full_lettersが空では登録できない' do
        @user.firstname_full_letters = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname full letters can't be blank")
      end

      it 'lastname_kanaが空では登録できない' do
        @user.lastname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
      end

      it 'firstname_kanaが空では登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      it 'lastname_full_lettersが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.lastname_full_letters = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname full letters 全角文字を使用してください')
      end

      it 'firstname_full_lettersが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.firstname_full_letters = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname full letters 全角文字を使用してください')
      end

      it 'lastname_kanaが全角（カタカナ）でないと登録できない' do
        @user.lastname_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname kana は全角カタカナで入力してください')
      end

      it 'firstname_kanaが全角（カタカナ）でないと登録できない' do
        @user.firstname_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname kana は全角カタカナで入力してください')
      end
    end
  end
end
