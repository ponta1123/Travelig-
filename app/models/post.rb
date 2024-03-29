class Post < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

def self.search(keyword)
  where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
end


  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end


end
