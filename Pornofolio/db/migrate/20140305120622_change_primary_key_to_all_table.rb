class ChangePrimaryKeyToAllTable < ActiveRecord::Migration
  def change
    # bigintに変更
    change_column :access_logs, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :post_analyses, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :post_comments, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :post_content_details, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :post_contents, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :post_likes, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :posts, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :user_favorites, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    change_column :users, :id, :integer, limit: 8, unsigned: true, auto_increment: true
    # smallintに変更
    change_column :post_types, :id, :integer, limit: 2, unsigned: true, auto_increment: true
    change_column :categories, :id, :integer, limit: 2, unsigned: true, auto_increment: true
    change_column :post_content_detail_types, :id, :integer, limit: 2, unsigned: true, auto_increment: true
    change_column :post_analysis_types, :id, :integer, limit: 2, unsigned: true, auto_increment: true
    change_column :post_content_types, :id, :integer, limit: 2, unsigned: true, auto_increment: true
    change_column :beta, :id, :integer, limit: 2, unsigned: true, auto_increment: true
  end
end