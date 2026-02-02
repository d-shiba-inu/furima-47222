class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 空の投稿禁止
  validates :nickname, :birth_date, :firstname_full_letters, :lastname_full_letters,
            :firstname_kana, :lastname_kana, presence: true
  ## 名前のバリデーション
  # 全角かな
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :firstname_full_letters, :lastname_full_letters
  end
  # 全角カナ
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' } do
    validates :lastname_kana
    validates :firstname_kana
  end
  # パスワード英数字混合
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
