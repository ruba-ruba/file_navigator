require 'spec_helper'

describe Folder do

  before do
    @folder = FactoryGirl.create(:folder)
  end

  subject { @folder }

  it { should respond_to(:title) }
  
end
