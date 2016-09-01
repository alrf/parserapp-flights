require 'spec_helper'

describe "airports/new.html.haml" do
  before(:each) do
    assign(:airport, stub_model(Airport,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new airport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => airports_path, :method => "post" do
      assert_select "input#airport_name", :name => "airport[name]"
    end
  end
end
