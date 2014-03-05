class ChangeOrderTypeColumnName < ActiveRecord::Migration
  def change
    Order.transaction do
      rename_column :orders, :type, :order_type
    end
  end
end
