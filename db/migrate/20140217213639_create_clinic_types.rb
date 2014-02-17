class CreateClinicTypes < ActiveRecord::Migration
  def change
    create_table :clinic_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
