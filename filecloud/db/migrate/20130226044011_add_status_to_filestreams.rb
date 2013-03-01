class AddStatusToFilestreams < ActiveRecord::Migration
  def change
  	add_column :filestreams, :status, :boolean, :default => false
  end
end
