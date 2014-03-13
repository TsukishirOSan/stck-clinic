require "spec_helper"

describe ClinicMailer do
  let(:clinic) { FactoryGirl.create(:clinic) }

  describe '.new_clinic_email' do
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

  describe '.new_order_email' do
    let(:order) { clinic.orders.first }
    let(:mail) { ClinicMailer.new_order_email(order) }

    describe 'message body' do
      subject { mail.body }

      context 'clinic address info' do
        it { should match(order.name) }
        it { should match(order.clinic.name) }
        it { should match(order.clinic.contact.name) }
      end

      context 'order info' do
        it { should match("Order is") }
        it { should match(order.card_quantity.to_s) }
        it { should match(order.brochure_quantity.to_s) }
        it { should match(order.order_type) }
      end
    end

    describe 'meta' do
      context 'recipient' do
        it { expect(mail.to).to eq(['john.and.kay@gmail.com']) }
      end

      context 'sender' do
        it { expect(mail.from).to eq(['noreply+StckClinicMonkey@sexualhealthinnovations.org']) }
      end
    end
  end
end

