require 'spec_helper'

describe Clinic do
  it { should validate_presence_of(:name) }
end
