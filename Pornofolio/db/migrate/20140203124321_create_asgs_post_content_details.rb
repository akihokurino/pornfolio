class CreateAsgsPostContentDetails < ActiveRecord::Migration
  def change
    create_table :asgs_post_content_details, :id => false do |t|
      t.integer :asg_id, :limit => 8, :null => false, :unsigned => true
      t.integer :post_content_detail_id, :limit => 8, :null => false, :unsigned => true
    end
    add_index :asgs_post_content_details, :asg_id
    add_index :asgs_post_content_details, :post_content_detail_id
  end
end
