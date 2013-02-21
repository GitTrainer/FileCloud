class CreateFoldertrees < ActiveRecord::Migration
  def change
    create_table :foldertrees do |t|

      t.timestamps
    end
  end
end
