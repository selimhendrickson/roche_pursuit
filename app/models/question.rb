class Question < ActiveRecord::Base
  belongs_to :quiz
  validates :quiz_id, presence: true
end
