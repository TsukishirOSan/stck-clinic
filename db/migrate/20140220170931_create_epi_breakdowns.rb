class CreateEpiBreakdowns < ActiveRecord::Migration
  def change
    create_table :epi_breakdowns do |t|
      t.string :name
      t.integer :clinic_id
      t.float :test_ct
      t.float :diag_ct
      t.float :test_gc
      t.float :diag_gc
      t.float :test_trich
      t.float :diag_trich
      t.float :test_hiv
      t.float :diag_hiv

      t.timestamps
    end
  end
end
