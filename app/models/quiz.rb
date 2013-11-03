class Quiz < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100}
end
