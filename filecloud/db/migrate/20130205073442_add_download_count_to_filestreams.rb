class AddDownloadCountToFilestreams < ActiveRecord::Migration
  def change
    add_column :filestreams, :download_count, :integer, :default => 0
  end
end
