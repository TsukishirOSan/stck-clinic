class AddStatusToOrder < ActiveRecord::Migration
  def change
    Order.transaction do
      add_column :orders, :status, :string
    end
  end
end
