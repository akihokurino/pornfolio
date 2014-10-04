class AddUnsignedForId < ActiveRecord::Migration
  def change
    change_column :access_logs, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :access_logs, :post_id, :integer, limit: 8, null: true, unsigned: true
    change_column :access_logs_ip_infos, :access_log_id, :integer, limit: 8, null: false, unsigned: true
    change_column :asgs_post_content_details, :asg_id, :integer, limit: 8, null: false, unsigned: true
    change_column :asgs_post_content_details, :post_content_detail_id, :integer, limit: 8, null: false, unsigned: true
    change_column :categories_posts, :category_id, :integer, limit: 8, null: false, unsigned: true
    change_column :categories_posts, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_analyses, :post_analysis_type_id, :integer, limit: 2, null: false, unsigned: true
    change_column :post_analyses, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_comments, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_comments, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_content_details, :post_content_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_content_details, :post_content_detail_type_id, :integer, limit: 2, null: false, unsigned: true
    change_column :post_content_details_xvideos, :post_content_detail_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_content_details_xvideos, :xvideos_id, :integer, null: false, unsigned: true
    change_column :post_contents, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_contents, :post_content_type_id, :integer, limit: 2, null: false, unsigned: true
    change_column :post_likes, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :post_likes, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :posts, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :posts, :post_type_id, :integer, limit: 2, null: false, unsigned: true
    change_column :posts_tags, :post_id, :integer, limit: 8, null: false, unsigned: true
    change_column :posts_tags, :tag_id, :integer, null: false, unsigned: true
    change_column :user_contacts, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :user_favorites, :user_id, :integer, limit: 8, null: false, unsigned: true
    change_column :user_favorites, :post_id, :integer, limit: 8, null: true, unsigned: true
    change_column :user_favorites, :post_content_id, :integer, limit: 8, null: true, unsigned: true
    change_column :xvideos, :video_id, :integer, null: false, unsigned: true
  end
end