class ChangeColumnLikeCountOfPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :like_count
  	add_column :posts, :like_count, :integer, :null => false, :default => 0
  end
end
