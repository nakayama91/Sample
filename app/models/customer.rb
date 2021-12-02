class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, uniqueness: true, presence: true
  validates :phone_number, uniqueness: true, presence: true
  validates :postal_code, presence: true, numericality: {only_integer:true}, length: {is: 7}
  validates :address, presence: true
  validates :is_deleted, inclusion: {in:[true,false]}

  #ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約
  def active_for_authentication?
    super && (is_deleted == false)
  end

  #フルネームを表示するための記述
  def fullname
    self.last_name + self.first_name
  end
  
  def fullname_kana
    self.last_name_kana + self.first_name_kana
  end
  
end
