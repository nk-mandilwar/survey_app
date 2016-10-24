class User < ActiveRecord::Base

	has_many :surveys, dependent: :destroy
	
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 15}

  def original_surveys
  	self.surveys.where.not("title LIKE ?", "CloneFrom_%")
  end
end
