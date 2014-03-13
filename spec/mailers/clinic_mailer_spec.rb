require "spec_helper"

describe ClinicMailer do
  let(:clinic) { FactoryGirl.create(:clinic) }
  let(:mail) { ClinicMailer.new_clinic_email(clinic) }

  describe 'message body' do
    subject { mail.body }

    it { should match("Lucky number") }
    it { should match(Clinic.model_name.human) }
    it { should match(clinic.name) }
  end

  describe 'meta' do
    context 'recipient' do
      it { expect(mail.to).to eq(['stckclinic@sexualhealthinnovations.org']) }
    end

    context 'sender' do
      it { expect(mail.from).to eq(['noreply+StckClinicMonkey@sexualhealthinnovations.org']) }
    end
  end
end
