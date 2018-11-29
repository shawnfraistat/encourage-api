class AdviceSerializer < ActiveModel::Serializer
  attributes :id, :content, :tags, :likes, :approved, :user, :favorites, :first_name, :last_name
  has_one :user
end
