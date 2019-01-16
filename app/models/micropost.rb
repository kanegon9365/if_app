class Micropost < ApplicationRecord
  belongs_to :user
  has_many :micropost_categories, dependent: :destroy
  has_many :categories, through: :micropost_categories
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 20}
  validates :content, presence: true, length: {maximum: 500}

  #カテゴリー更新処理
  def save_categories(tags)
    current_tags = self.categories.pluck(:name) unless self.categories.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.categories.delete Category.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      micropost_category = Category.find_or_create_by(name:new_name)
      self.categories << micropost_category
    end
  end

end
