class AdviceSerializer < ActiveModel::Serializer
  attributes :id, :content, :tags, :likes, :approved, :user, :first_name, :last_name
  has_one :user
end
