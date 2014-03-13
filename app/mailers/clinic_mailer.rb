class ClinicMailer < ActionMailer::Base
  default from: "noreply+StckClinicMonkey@example.com"

  def new_clinic_email(clinic)
    @clinic = clinic

    mail(to: 'stckclinic@sexualhealthinnovations.org',
         subject: "New #{Clinic.model_name.human} signup on STCK Clinic!")
  end
end
