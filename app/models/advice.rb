class Advice < ApplicationRecord
  belongs_to :user
  has_many :likes
  attr_accessor :first_name, :last_name, :last_initial
end
