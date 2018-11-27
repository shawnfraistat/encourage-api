class LikeSerializer < ActiveModel::Serializer
  attributes :id
  has_one :advice
  has_one :user
end
