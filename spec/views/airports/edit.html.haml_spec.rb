require 'spec_helper'

describe "airports/edit.html.haml" do
  before(:each) do
    @airport = assign(:airport, stub_model(Airport,
      :name => "MyString"
    ))
  end

  it "renders the edit airport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => airports_path(@airport), :method => "post" do
      assert_select "input#airport_name", :name => "airport[name]"
    end
  end
end
