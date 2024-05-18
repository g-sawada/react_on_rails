class User < ApplicationRecord
  has_many :graphs, dependent: :destroy
  has_many :templates, dependent: :destroy
end
