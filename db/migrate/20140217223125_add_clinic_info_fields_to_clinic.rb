class AddClinicInfoFieldsToClinic < ActiveRecord::Migration
  def change
    Clinic.transaction do
      add_column :clinics, :street_address_continued, :string
      add_column :clinics, :contact_name, :string
      add_column :clinics, :contact_title, :string
      add_column :clinics, :contact_email, :string
      add_column :clinics, :contact_phone, :string
      add_column :clinics, :notes, :text
    end
  end
end
