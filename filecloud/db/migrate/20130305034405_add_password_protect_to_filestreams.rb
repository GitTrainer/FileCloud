class AddPasswordProtectToFilestreams < ActiveRecord::Migration
  def change
  	add_column :filestreams, :password_protect, :string
  end
end
