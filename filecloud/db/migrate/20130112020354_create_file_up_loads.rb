class CreateFileUpLoads < ActiveRecord::Migration
  def change
    create_table :file_up_loads do |t|
      t.integer :folder_id

      t.timestamps
    end
  end
end
