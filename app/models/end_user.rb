class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  VALID_NAME_KANA_REGEX = /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/
  validates :last_name_kana, :first_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: "は全角カタカナのみで入力して下さい" }

  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX }

  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }

  validates :address, length: { minimum: 10, maximum: 100 }
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, presence: true

  def active_for_authentication?  # 状態は有効ですよ & devise継承 メソッド自作
    super && (self.is_deleted == false )  #falseは有効
    #superは、継承元のメソッドを呼び出すことができるメソッド
    #ここでのsuperは、deviseに存在している認証機能を継承してくれてる
    #且つ、退会済みのユーザーを弾く　selfは、ここではEndUserモデルを指す
  end

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders
end