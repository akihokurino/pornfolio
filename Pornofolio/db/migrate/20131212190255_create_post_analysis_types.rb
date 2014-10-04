class CreatePostAnalysisTypes < ActiveRecord::Migration
  def change
    create_table :post_analysis_types do |t|
      t.string :name, :limit => 100, :null => false

    end
    add_index :post_analysis_types, :name, :unique => true
  end
end
