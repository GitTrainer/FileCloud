class AddLinkTokenToSharefiles < ActiveRecord::Migration
  def change
    add_column :sharefiles, :link_token, :string
  end
end
