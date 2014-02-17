require 'spec_helper'

describe ClinicType do
  it { should validate_presence_of(:name) }
end
