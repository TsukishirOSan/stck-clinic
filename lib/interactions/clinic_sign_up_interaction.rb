class ClinicSignUpInteraction < ActiveInteraction::Base
  # clinic info
  string :clinic_name, :clinic_street_address, :clinic_street_address_continued,
         :clinic_city, :clinic_state, :clinic_zip

  validates :clinic_name, presence: true
  validates :clinic_street_address, presence: true
  validates :clinic_state, presence: true
  validates :clinic_city, presence: true
  validates :clinic_zip, presence: true

  string :contact_name, :contact_phone, :contact_email, :contact_title

  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :contact_email, presence: true

  def execute
    clinic = create_clinic
    create_contact(clinic)
  end

  def create_contact(clinic)
    attrs = map_attrs({
                        :contact_email => :email,
                        :contact_name => :name,
                        :contact_phone => :phone,
                        :contact_title => :title,
                      }).merge(clinic: clinic)

    Rails.logger.info("Attempting to create #{Contact.model_name.human}")
    Contact.create!(attrs)
  end

  def create_clinic
    attrs = map_attrs({
                        :clinic_city                     => :city,
                        :clinic_name                     => :name,
                        :clinic_state                    => :state,
                        :clinic_street_address           => :street_address,
                        :clinic_street_address_continued => :street_address_continued,
                        :clinic_zip                      => :zip,
                      })

    Rails.logger.info("Attempting to create #{Clinic.model_name.human}")
    Clinic.create!(attrs)
  end

  def map_attrs(hsh)
    hsh.map do |input_name, output_name|
      { output_name => inputs[input_name] }
    end.reduce(&:merge)
  end
end
