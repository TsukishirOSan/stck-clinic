require 'spec_helper'

describe Clinic do
  it { should validate_presence_of(:name) }
  # basic info
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:zip) }
end
