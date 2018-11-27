# frozen_string_literal: true

class User < ApplicationRecord
  include Authentication
  has_many :examples
  has_many :advices, dependent: :destroy
  has_many :likes, dependent: :destroy
end
