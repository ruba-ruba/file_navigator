require 'spec_helper'

describe Comment do

  let(:comment) { FactoryGirl.create(:folder_comment) }

  subject { comment }

  it { should respond_to(:content) }
  it { should respond_to(:commentable_type) }
  it { should respond_to(:commentable_id) }
end
