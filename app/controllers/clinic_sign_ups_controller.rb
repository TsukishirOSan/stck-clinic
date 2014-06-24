class ClinicSignUpsController < ApplicationController
  def index
  end

  def new
    @clinic_sign_up_interaction = ClinicSignUpInteraction.new
  end

  def create
    @clinic_sign_up_interaction = ClinicSignUpInteraction.run(clinic_sign_up_interaction_params)

    if @clinic_sign_up_interaction.valid?
      render action: 'show'
    else
      render :action => 'new', :status => :unprocessable_entity
    end
  end

  private
  def clinic_sign_up_interaction_params
    params.require(:clinic_sign_up_interaction).permit(:clinic_name, :clinic_street_address, :clinic_street_address_continued, :clinic_city, :clinic_state, :clinic_zip, :contact_name, :contact_title, :contact_phone, :contact_email, :college_health, :community_health, :family_planning, :other, :planned_parenthood, :private_practice, :std)
  end
end
