class RemoveUpvotesFromAdvices < ActiveRecord::Migration[5.2]
  def change
    remove_column :advices, :upvotes, :integer
  end
end
