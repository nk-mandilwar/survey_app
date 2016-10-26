class Feedback < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  apply_simple_captcha message: "text does not match"

  accepts_nested_attributes_for :answers

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }
end
