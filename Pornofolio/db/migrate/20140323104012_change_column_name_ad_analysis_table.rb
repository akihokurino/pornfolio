class ChangeColumnNameAdAnalysisTable < ActiveRecord::Migration
  def change
    rename_column :ad_analyses, :access_url, :view_url
  end
end
