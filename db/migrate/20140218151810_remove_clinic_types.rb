class RemoveClinicTypes < ActiveRecord::Migration
  def change
    drop_table :clinic_types
  end
end
