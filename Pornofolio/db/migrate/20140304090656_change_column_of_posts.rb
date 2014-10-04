class ChangeColumnOfPosts < ActiveRecord::Migration
  def change
  	change_column :posts, :like_count, :integer, :default => 0
  end
end
