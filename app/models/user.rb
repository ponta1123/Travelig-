class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def self.guest
   find_or_create_by!(email: "guest@aiu.com") do |user|
     user.password = SecureRandom.urlsafe_base64
     user.name = "ゲスト"
     user.address = "ゲスト大分県"
   end
 end

  has_many :posts, dependent: :destroy
  has_one_attached :image

end
