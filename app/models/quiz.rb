class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :takes, foreign_key: "quiz_id", dependent: :destroy
  has_many :users, through: :takes
  validates :title, presence: true, length: { maximum: 100}
  
end
