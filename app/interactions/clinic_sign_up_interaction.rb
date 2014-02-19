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

  boolean :college_health,
          :community_health,
          :family_planning,
          :other,
          :planned_parenthood,
          :private_practice,
          :std

  validate :ensure_some_service_offered

  def execute
    clinic = create_clinic
    create_contact(clinic)
    create_service_offering_description(clinic)
  end

  def create_service_offering_description(clinic)
    attrs = map_attrs({
                        :college_health => :college_health,
                        :community_health => :community_health,
                        :family_planning => :family_planning,
                        :other => :other,
                        :planned_parenthood => :planned_parenthood,
                        :private_practice => :private_practice,
                        :std => :std
                      })
            .merge(clinic: clinic,
                   name: "#{ServiceOfferingDescription.model_name.human} for #{Clinic.model_name.human}")
    Rails.logger.info("Attempting to create #{ServiceOfferingDescription.model_name.human}")
    ServiceOfferingDescription.create!(attrs)
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

  def ensure_some_service_offered
    if [college_health,
        community_health,
        family_planning,
        other,
        planned_parenthood,
        private_practice,
        std].any?
      true
    else
      self.errors.add(:base, "you must specify some service!")
    end
  end

end
