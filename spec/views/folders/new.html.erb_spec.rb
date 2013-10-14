require 'spec_helper'

describe "folders/new" do
  before(:each) do
    assign(:folder, stub_model(Folder,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", folders_path, "post" do
      assert_select "input#folder_title[name=?]", "folder[title]"
    end
  end
end
