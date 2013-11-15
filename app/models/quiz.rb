class Quiz < ActiveRecord::Base
  has_many :questions
  validates :title, presence: true, length: { maximum: 100}

end
