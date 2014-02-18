require 'spec_helper'

describe 'Clinic sign up', type: :feature do
  before(:each) do
    visit new_clinic_sign_up_path
  end

  describe 'form submission' do

    let(:clinic) { FactoryGirl.build(:clinic) }
    let(:contact) { FactoryGirl.build(:contact) }

    context 'given required information' do
      before(:each) do
        pending
        fill_in 'Clinic name', :with => clinic.name
      end

      it 'submits successfully' do
        pending "unspecified behavior"
        click_on 'Create Clinic'
        expect(page.status_code).to eq(200)
      end

      it 'creates a clinic' do
        pending "unspecified behavior"
        expect {
          click_on 'Create Clinic'
        }.to change(Clinic, :count).by(1)
      end
    end
  end
end
