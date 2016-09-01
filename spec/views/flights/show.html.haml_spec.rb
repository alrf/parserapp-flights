require 'spec_helper'

describe "flights/show.html.haml" do
  before(:each) do
    @flight = assign(:flight, stub_model(Flight,
      :date => "Date",
      :flight => "Flight",
      :departure_airport => 1,
      :arrival_airport => 1,
      :econom => "Econom"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Date/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Flight/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Econom/)
  end
end
