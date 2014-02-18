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
    params.require(:clinic_sign_up_interaction).permit(:clinic_name)
  end
end
