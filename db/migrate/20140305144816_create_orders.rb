class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :clinic_id
      t.integer :card_quantity
      t.integer :brochure_quantity
      t.date :sent_on
      t.string :type
      t.float :envelope_cost
      t.float :postage_cost
      t.string :clinic_code
      t.string :use
      t.text :notes

      t.timestamps
    end
  end
end
