require 'spec_helper'

describe "folders/edit" do
  before(:each) do
    @folder = assign(:folder, stub_model(Folder,
      :title => "MyString"
    ))
  end

  it "renders the edit folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", folder_path(@folder), "post" do
      assert_select "input#folder_title[name=?]", "folder[title]"
    end
  end
end
