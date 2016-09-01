require 'spec_helper'

describe "flights/index.html.haml" do
  before(:each) do
    assign(:flights, [
      stub_model(Flight,
        :date => "Date",
        :flight => "Flight",
        :departure_airport => 1,
        :arrival_airport => 1,
        :econom => "Econom"
      ),
      stub_model(Flight,
        :date => "Date",
        :flight => "Flight",
        :departure_airport => 1,
        :arrival_airport => 1,
        :econom => "Econom"
      )
    ])
  end

  it "renders a list of flights" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Date".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Flight".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Econom".to_s, :count => 2
  end
end
