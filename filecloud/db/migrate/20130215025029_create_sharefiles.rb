class CreateSharefiles < ActiveRecord::Migration
  def change
    create_table :sharefiles do |t|
      t.string :email
      t.integer :upload_id

      t.timestamps
    end
  end
end
