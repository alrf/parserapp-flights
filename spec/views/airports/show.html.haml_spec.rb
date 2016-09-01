require 'spec_helper'

describe "airports/show.html.haml" do
  before(:each) do
    @airport = assign(:airport, stub_model(Airport,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
