class MicropostCategory < ApplicationRecord
  belongs_to :micropost
  belongs_to :category
  validates :micropost_id, presence: true
  validates :category_id, presence: true
end
