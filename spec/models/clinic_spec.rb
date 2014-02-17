require 'spec_helper'

describe Clinic do
  it { should validate_presence_of(:name) }
  # basic info
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:zip) }
  # contact info
  it { should validate_presence_of(:contact_email) }
  it { should validate_presence_of(:contact_name) }
  it { should validate_presence_of(:contact_phone) }
  it { should validate_presence_of(:contact_title) }
end
