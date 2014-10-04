class AddColumnUncensoredForPostsTable < ActiveRecord::Migration
  def change
    add_column :posts, :is_uncensored, :boolean, default: false, null: false
  end
end
