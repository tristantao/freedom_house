class AddAdminVerifiedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :admin_verified, :boolean
  end
end
