class ClinicMailer < ActionMailer::Base
  default from: "noreply+StckClinicMonkey@sexualhealthinnovations.org"

  def new_clinic_email(clinic)
    @clinic = clinic

    mail(to: 'stckclinic@sexualhealthinnovations.org',
         subject: "New #{Clinic.model_name.human} signup on STCK Clinic!")
  end

  def new_order_email(order)
    @order = order
    @clinic = order.clinic

    mail(to: 'john.and.kay@gmail.com',
         subject: "New #{Order.model_name.human} created on STCK Clinic!")
  end
end
