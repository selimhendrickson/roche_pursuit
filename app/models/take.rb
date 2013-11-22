class Take < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :quiz, class_name: "Quiz"
  validates :user_id, presence: true
  validates :quiz_id, presence: true
end
