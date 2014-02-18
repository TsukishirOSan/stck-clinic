class CreateServiceOfferingDescriptions < ActiveRecord::Migration
  def change
    create_table :service_offering_descriptions do |t|
      t.string :name
      t.integer :clinic_id
      t.boolean :college_health
      t.boolean :community_health
      t.boolean :family_planning
      t.boolean :planned_parenthood
      t.boolean :private_practice
      t.boolean :std
      t.boolean :other

      t.timestamps
    end
  end
end
