require 'spec_helper'

describe "flights/edit.html.haml" do
  before(:each) do
    @flight = assign(:flight, stub_model(Flight,
      :date => "MyString",
      :flight => "MyString",
      :departure_airport => 1,
      :arrival_airport => 1,
      :econom => "MyString"
    ))
  end

  it "renders the edit flight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => flights_path(@flight), :method => "post" do
      assert_select "input#flight_date", :name => "flight[date]"
      assert_select "input#flight_flight", :name => "flight[flight]"
      assert_select "input#flight_departure_airport", :name => "flight[departure_airport]"
      assert_select "input#flight_arrival_airport", :name => "flight[arrival_airport]"
      assert_select "input#flight_econom", :name => "flight[econom]"
    end
  end
end
