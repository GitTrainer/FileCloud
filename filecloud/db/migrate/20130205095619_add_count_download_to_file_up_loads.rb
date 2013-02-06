class AddCountDownloadToFileUpLoads < ActiveRecord::Migration
  def change
  	add_column :file_up_loads,:count_download ,:integer, default: 0
  end
end
