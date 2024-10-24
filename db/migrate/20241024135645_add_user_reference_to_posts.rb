class AddUserReferenceToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, null: false, foreign_key: true, if_not_exists: true
  end
end
