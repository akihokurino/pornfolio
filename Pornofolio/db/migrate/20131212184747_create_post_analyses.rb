class CreatePostAnalyses < ActiveRecord::Migration
  def change
    create_table :post_analyses do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :count, :null => false, :default => 0, unsigned: true
      t.integer :post_analysis_type_id, :null => false, unsigned: true
      t.datetime :measured_at, :null => false

      t.timestamps
    end
    add_index :post_analyses, [:post_id, :post_analysis_type_id, :measured_at], :name => 'post_analyses_index'
    add_index :post_analyses, [:measured_at, :post_analysis_type_id]
  end
end
