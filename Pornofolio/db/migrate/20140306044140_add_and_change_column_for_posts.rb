class AddAndChangeColumnForPosts < ActiveRecord::Migration
  def change
    add_column :posts, :view_count, :integer, null: false, default: 0, unsigned: true
    change_column :posts, :like_count, :integer, null: false, default: 0, unsigned: true
  end
end
