class ChangeAdColumnName < ActiveRecord::Migration
  def change
    rename_column :ads, :ad_company, :company
    rename_column :ads, :ad_object, :url
  end
end