class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  before_save { email.downcase! }
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length:{maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :picture_size

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "容量が大きいよう...")
      end
    end
end
