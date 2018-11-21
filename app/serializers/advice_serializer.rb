class AdviceSerializer < ActiveModel::Serializer
  attributes :id, :content, :tags, :upvotes, :approved
  has_one :user
end
