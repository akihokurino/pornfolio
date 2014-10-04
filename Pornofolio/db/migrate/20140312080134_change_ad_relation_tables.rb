class ChangeAdRelationTables < ActiveRecord::Migration
  def change
    remove_index  :ads, :ad_company_id
    rename_column :ads, :ad_company_id, :ad_company
    change_column :ads, :ad_company, :string, limit: 50, null: false
    add_index     :ads, :ad_company
  end
end
