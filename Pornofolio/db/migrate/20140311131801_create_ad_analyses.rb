class CreateAdAnalyses < ActiveRecord::Migration
  def change
    create_table :ad_analyses do |t|
      t.integer :ad_id, limit: 2, null: false, unsigned: true
      t.integer :user_id, limit: 8, null: false, unsigned: true
      t.integer :post_id, limit: 8, null: true, unsigned: true, default: nil
      t.text :access_url, null: false

      t.timestamps
    end
    add_index :ad_analyses, :ad_id
    add_index :ad_analyses, [:ad_id, :user_id]
    add_index :ad_analyses, [:ad_id, :post_id]
    change_column :ad_analyses, :id, :integer, limit: 8, unsigned: true, auto_increment: true
  end
end
