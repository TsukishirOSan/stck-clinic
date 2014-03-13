# Interaction encompassing the entire clinic signup process
class ClinicSignUpInteraction < ActiveInteraction::Base
  include Contracts

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

  string :charge_ct, :notify_test_ready

  boolean :deliver_results_online,
          :deliver_results_in_person,
          :deliver_results_on_phone_human,
          :deliver_results_on_phone_automated,
          :deliver_results_other

  include EnsureOneService

  float :population_women,
        :population_msm,
        :population_under_26,
        :population_hispanic,
        :population_black

  float :test_ct,    :diag_ct,
        :test_gc,    :diag_gc,
        :test_trich, :diag_trich,
        :test_hiv,   :diag_hiv

  Contract nil => Clinic
  # Required method called by `run` to actually do this interaction
  # @note this method will end up creating and persisted an entire
  # {Clinic} object graph if validations succeed.
  # @return [Clinic] the created clinic
  def execute
    clinic = create_clinic
    create_contact(clinic)
    create_service_offering_description(clinic)
    create_population_breakdown(clinic)
    create_epi_breakdown(clinic)

    clinic
  end

  Contract Clinic => PopulationBreakdown
  # @param [Clinic] clinic the parent clinic
  # @return [PopulationBreakdown] new {PopulationBreakdown} attached to the clinic
  def create_population_breakdown(clinic)
    attrs = map_attrs({
                        :population_black    => :black,
                        :population_hispanic => :hispanic,
                        :population_msm      => :msm,
                        :population_under_26 => :under_26,
                        :population_women    => :women
                      }, clinic, PopulationBreakdown)

    Rails.logger.info("Attempting to create #{PopulationBreakdown.model_name.human}")
    PopulationBreakdown.create!(attrs)
  end

  Contract Clinic => EpiBreakdown
  # @param [Clinic] clinic the parent {Clinic}
  # @return [EpiBreakdown] new {EpiBreakdown} attached to the {Clinic}
  def create_epi_breakdown(clinic)
    attrs = map_attrs({
                        :test_ct    => :test_ct,
                        :diag_ct    => :diag_ct,
                        :test_gc    => :test_gc,
                        :diag_gc    => :diag_gc,
                        :test_trich => :test_trich,
                        :diag_trich => :diag_trich,
                        :test_hiv   => :test_hiv,
                        :diag_hiv   => :diag_hiv
                      }, clinic, EpiBreakdown)
    Rails.logger.info("Attempting to create #{EpiBreakdown.model_name.human}")
    EpiBreakdown.create!(attrs)
  end

  Contract Clinic => ServiceOfferingDescription
  # @param [Clinic] clinic the parent {Clinic}
  # @return [ServiceOfferingDescription] new {ServiceOfferingDescription} attached to the {Clinic}
  def create_service_offering_description(clinic)
    attrs = map_attrs({
                        :college_health     => :college_health,
                        :community_health   => :community_health,
                        :family_planning    => :family_planning,
                        :other              => :other,
                        :planned_parenthood => :planned_parenthood,
                        :private_practice   => :private_practice,
                        :std                => :std
                      }, clinic, ServiceOfferingDescription)
    Rails.logger.info("Attempting to create #{ServiceOfferingDescription.model_name.human}")
    ServiceOfferingDescription.create!(attrs)
  end

  Contract Clinic => Contact
  # @param [Clinic] clinic the parent {Clinic}
  # @return [Contact] new {Contact} attached to the {Clinic}
  def create_contact(clinic)
    attrs = map_attrs({
                        :contact_email => :email,
                        :contact_name  => :name,
                        :contact_phone => :phone,
                        :contact_title => :title
                      }, clinic).merge(clinic: clinic)

    Rails.logger.info("Attempting to create #{Contact.model_name.human}")
    Contact.create!(attrs)
  end

  Contract nil => Clinic
  # @return [Clinic] primary {Clinic} being created
  def create_clinic
    attrs = map_attrs(:clinic_city                     => :city,
                      :clinic_name                     => :name,
                      :clinic_state                    => :state,
                      :clinic_street_address           => :street_address,
                      :clinic_street_address_continued => :street_address_continued,
                      :clinic_zip                      => :zip)

    Rails.logger.info("Attempting to create #{Clinic.model_name.human}")
    Clinic.create!(attrs)
  end

  Contract Hash, Maybe[Clinic], Maybe[Class], Maybe[String] => Hash
  # Map attributes from one hash to another
  # @param [Hash] hsh hash containing the actual attributes
  # @param [Clinic,nil] clinic the {Clinic} in question
  # @param [Class,nil] klass the Class of the object for which the attributes will be used to initialize
  # @param [String,nil] default the default value in case property lookup fails
  # @return [Hash]
  def map_attrs(hsh, clinic = nil, klass = nil, default = nil)
    output = hsh.map do |input_name, output_name|
      { output_name => inputs.fetch(input_name, default) }
    end.reduce(&:merge)

    if klass.present?
      output = {
        name: "#{klass.model_name.human} for #{Clinic.model_name.human} #{clinic.name}"
      }.merge(output)
    end

    output = { clinic: clinic }.merge(output) if clinic.present?

    output
  end
end
