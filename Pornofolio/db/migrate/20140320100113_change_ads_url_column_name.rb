class ChangeAdsUrlColumnName < ActiveRecord::Migration
  def change
    rename_column :ads, :url, :ad_object
  end
end
