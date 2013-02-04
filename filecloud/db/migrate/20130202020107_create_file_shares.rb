class CreateFileShares < ActiveRecord::Migration
  def change
    create_table :file_shares do |t|
      t.integer :user_id
      t.integer :file_up_load_id

      t.timestamps
    end
  end
end
