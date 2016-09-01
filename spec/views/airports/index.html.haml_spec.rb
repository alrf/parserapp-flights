require 'spec_helper'

describe "airports/index.html.haml" do
  before(:each) do
    assign(:airports, [
      stub_model(Airport,
        :name => "Name"
      ),
      stub_model(Airport,
        :name => "Name"
      )
    ])
  end

  it "renders a list of airports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
