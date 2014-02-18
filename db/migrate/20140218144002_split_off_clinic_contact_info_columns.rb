class SplitOffClinicContactInfoColumns < ActiveRecord::Migration
  def change
    Clinic.transaction do
      [
        :contact_name,
        :contact_email,
        :contact_phone,
        :contact_title
      ].each do |column_name|
        remove_column :clinics, column_name
      end
    end
  end
end
