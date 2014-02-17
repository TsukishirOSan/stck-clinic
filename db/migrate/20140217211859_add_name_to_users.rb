class AddNameToUsers < ActiveRecord::Migration
  def change
    User.transaction do
      add_column :users, :name, :string
    end
  end
end
