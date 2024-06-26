class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 10 }
  validates :body, presence: true, length: { maximum: 100 }
end
