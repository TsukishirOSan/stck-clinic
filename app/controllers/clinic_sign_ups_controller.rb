class ClinicSignUpsController < ApplicationController
  def index
  end

  def new
    @clinic = Clinic.new
  end

  def create
    @clinic = Clinic.new(clinic_params)

    if @clinic.save
      render action: 'show'
    else
      render action: 'new'
    end
  end

  private
  def clinic_params
    params.require(:clinic).permit(:name)
  end
end
