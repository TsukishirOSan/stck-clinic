class AddAdminToggleToUser < ActiveRecord::Migration
  def change
    User.transaction do
      add_column :users, :admin, :boolean
    end
  end
end
