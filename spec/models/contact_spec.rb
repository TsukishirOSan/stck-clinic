require 'spec_helper'

describe Contact do
  # contact info

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :clinic }
end
