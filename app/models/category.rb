class Category < ApplicationRecord
  has_many :microposts_categories, dependent: :destroy
  has_many :microposts, through: :microposts_categories
  validates :name, presence: true, length:{maximum: 15}
end
