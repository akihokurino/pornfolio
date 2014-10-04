class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.text :text, :null => false

      t.timestamps
    end

  end
end
