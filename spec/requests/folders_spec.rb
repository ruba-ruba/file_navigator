require 'spec_helper'

describe "Folders" do

  subject { page }

  let(:folder) {FactoryGirl.create(:folder)}

  describe "delete multiple" do
    let!(:folder1) {FactoryGirl.create(:folder, title: 'folder1')}
    let!(:folder2) {FactoryGirl.create(:folder, title: 'folder2')}
    let!(:folder3) {FactoryGirl.create(:folder, title: 'folder3')}

    it "should delete multiple folders" do
      get folders_path
      response.status.should be(200)
      #find(:css, "input[value='#{folder1.id}']").set(true)

    end
  end


end
