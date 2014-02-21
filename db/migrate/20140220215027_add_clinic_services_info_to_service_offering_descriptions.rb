class AddClinicServicesInfoToServiceOfferingDescriptions < ActiveRecord::Migration
  def change
    ServiceOfferingDescription.transaction do
      add_column :service_offering_descriptions, :charge_ct, :string
      add_column :service_offering_descriptions, :notify_test_ready, :string

      [
        :deliver_results_online,
        :deliver_results_in_person,
        :deliver_results_on_phone_human,
        :deliver_results_on_phone_automated,
        :deliver_results_other
      ].each do |option_name|
        add_column :service_offering_descriptions, option_name, :boolean
      end
    end
  end
end
