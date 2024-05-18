class User < ApplicationRecord
  has_many :graphs
  has_many :templates
end
