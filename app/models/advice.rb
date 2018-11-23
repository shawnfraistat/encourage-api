class Advice < ApplicationRecord
  belongs_to :user
  attr_accessor :first_name, :last_name, :last_initial
end
