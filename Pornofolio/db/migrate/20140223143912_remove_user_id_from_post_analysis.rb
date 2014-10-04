class RemoveUserIdFromPostAnalysis < ActiveRecord::Migration
  def change
  	remove_column :post_analyses, :user_id
  end
end
