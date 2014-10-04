class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.text :ad_object, null: false
      t.integer :ad_company_id, limit: 2, null: false, unsigned: true
    end
    add_index :ads, :ad_company_id
    change_column :ads, :id, :integer, limit: 2, unsigned: true, auto_increment: true
  end
end
