class ChangeCountDefaultValueForPostAnalysis < ActiveRecord::Migration
  def change
    change_column :post_analyses, :count, :integer, null: false, default: 1, unsigned: true
  end
end
