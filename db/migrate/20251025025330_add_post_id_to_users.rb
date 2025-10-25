class AddPostIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :post_id, :integer
  end
end
