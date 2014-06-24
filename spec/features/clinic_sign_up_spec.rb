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
        fill_in 'Clinic name', :with => clinic.name
        within('.clinic_sign_up_interaction_clinic_street_address') do
          fill_in 'Clinic street address', :with => clinic.street_address
        end
        fill_in 'Clinic city', :with => clinic.city
        fill_in 'Clinic state', :with => clinic.state
        fill_in 'Clinic zip', :with => clinic.zip
        fill_in 'Contact name', :with => contact.name
        fill_in 'Contact phone', :with => contact.phone
        fill_in 'Contact email', :with => contact.email
      end

      it 'submits successfully' do
        click_on 'Create Clinic'
        expect(page.status_code).to eq(200)
      end

      xit 'creates a clinic' do
        expect {
          click_on 'Create Clinic sign up interaction'
        }.to change(Clinic, :count).by(1)
      end
    end
  end
end
