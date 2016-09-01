require "spec_helper"

describe FlightsController do
  describe "routing" do

    it "routes to #index" do
      get("/flights").should route_to("flights#index")
    end

    it "routes to #new" do
      get("/flights/new").should route_to("flights#new")
    end

    it "routes to #show" do
      get("/flights/1").should route_to("flights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/flights/1/edit").should route_to("flights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/flights").should route_to("flights#create")
    end

    it "routes to #update" do
      put("/flights/1").should route_to("flights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/flights/1").should route_to("flights#destroy", :id => "1")
    end

  end
end
