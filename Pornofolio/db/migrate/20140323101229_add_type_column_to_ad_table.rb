class AddTypeColumnToAdTable < ActiveRecord::Migration
  def change
    add_column :ads, :ad_type, :string, limit: 100, null: false
    add_index :ads, :ad_type
    add_index :ads, [:company, :ad_type]
  end
end
