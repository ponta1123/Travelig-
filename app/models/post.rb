class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

def self.search(keyword)
  where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
end


end
