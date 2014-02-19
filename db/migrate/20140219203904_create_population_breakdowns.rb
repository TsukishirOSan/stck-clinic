class CreatePopulationBreakdowns < ActiveRecord::Migration
  def change
    create_table :population_breakdowns do |t|
      t.string :name
      t.float :women
      t.float :msm
      t.float :under_26
      t.float :black
      t.float :hispanic
      t.integer :clinic_id

      t.timestamps
    end
  end
end
