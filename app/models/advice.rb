class Advice < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # the reason for this attr_accessor is to make it possible to return an advice
  # object with some additional information about the user who created it--
  # used in the show and getrandom methods specificed in the advices controller
  attr_accessor :first_name, :last_name, :last_initial
end
