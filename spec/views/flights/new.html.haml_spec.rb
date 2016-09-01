require 'spec_helper'

describe "flights/new.html.haml" do
  before(:each) do
    assign(:flight, stub_model(Flight,
      :date => "MyString",
      :flight => "MyString",
      :departure_airport => 1,
      :arrival_airport => 1,
      :econom => "MyString"
    ).as_new_record)
  end

  it "renders new flight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => flights_path, :method => "post" do
      assert_select "input#flight_date", :name => "flight[date]"
      assert_select "input#flight_flight", :name => "flight[flight]"
      assert_select "input#flight_departure_airport", :name => "flight[departure_airport]"
      assert_select "input#flight_arrival_airport", :name => "flight[arrival_airport]"
      assert_select "input#flight_econom", :name => "flight[econom]"
    end
  end
end
