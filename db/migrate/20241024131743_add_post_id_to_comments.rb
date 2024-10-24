class AddPostIdToComments < ActiveRecord::Migration[7.1]
  def up
    add_reference :comments, :post, null: true, foreign_key: true
  end

  def down
    remove_reference :comments, :post
  end
end
