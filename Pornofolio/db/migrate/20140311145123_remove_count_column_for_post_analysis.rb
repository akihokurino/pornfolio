class RemoveCountColumnForPostAnalysis < ActiveRecord::Migration
  def change
    remove_column :post_analyses, :count
  end
end
