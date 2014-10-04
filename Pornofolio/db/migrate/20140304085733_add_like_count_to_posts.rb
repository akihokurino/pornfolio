class AddLikeCountToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :like_count, :integer, :limit => 8
  end
end
