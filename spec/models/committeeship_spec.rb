require 'spec_helper'

describe Committeeship do
  before(:each) do
    @dude = mock_model Person
    @cship = Committeeship.new({
      :committee => 'compserv',
      :semester => '20103',
      :title => 'officer',
    })
    @cship.person = @dude
    end
  it "should accept valid parameters" do
    @cship.should be_valid
  end
  it "should require a valid semester" do
    @cship.semester = '20105'
    @cship.should_not be_valid
  end
  it "should require a valid committee" do
    @cship.committee = 'pubrel'
    @cship.should_not be_valid
  end
  it "should require a valid title" do
    @cship.title = 'hoser'
    @cship.should_not be_valid
  end  
end
