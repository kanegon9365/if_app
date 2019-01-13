class Category < ApplicationRecord
  has_many :microposts, through: :micropost_categories
  has_many :micropost_categories, dependent: :destroy
  validates :name, presence: true, length:{maximum: 15}
end
