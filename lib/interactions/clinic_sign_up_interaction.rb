class ClinicSignUpInteraction < ActiveInteraction::Base
  # clinic info
  string :clinic_name, :clinic_street_address, :clinic_street_address_continued,
         :clinic_city, :clinic_state, :clinic_zip

  validates :clinic_name, presence: true
  validates :clinic_street_address, presence: true
  validates :clinic_state, presence: true
  validates :clinic_city, presence: true
  validates :clinic_zip, presence: true

  def execute
    create_clinic
  end

  def create_clinic
    attrs = {
      :clinic_city                     => :city,
      :clinic_name                     => :name,
      :clinic_state                    => :state,
      :clinic_street_address           => :street_address,
      :clinic_street_address_continued => :street_address_continued,
      :clinic_zip                      => :zip,
    }.map do |input_name, output_name|
      { output_name => inputs[input_name] }
    end.reduce(&:merge)

    Clinic.create!(attrs)
  end
end
