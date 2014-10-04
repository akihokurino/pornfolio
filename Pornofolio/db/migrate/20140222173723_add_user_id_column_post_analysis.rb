class AddUserIdColumnPostAnalysis < ActiveRecord::Migration
  def change
    add_column :post_analyses, :user_id, :integer, :limit => 8, :null => false, :unsigned => true
    add_index :post_analyses, :user_id
  end
end
