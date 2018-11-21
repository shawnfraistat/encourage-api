class CreateAdvices < ActiveRecord::Migration[5.2]
  def change
    create_table :advices do |t|
      t.string :content
      t.string :tags
      t.integer :upvotes
      t.string :approved
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
