class CreateFilestreams < ActiveRecord::Migration
  def change
    create_table :filestreams do |t|
      t.string :filename
      t.integer :folder_id

      t.timestamps
    end
  end
end
