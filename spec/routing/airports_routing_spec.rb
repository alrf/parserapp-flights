require "spec_helper"

describe AirportsController do
  describe "routing" do

    it "routes to #index" do
      get("/airports").should route_to("airports#index")
    end

    it "routes to #new" do
      get("/airports/new").should route_to("airports#new")
    end

    it "routes to #show" do
      get("/airports/1").should route_to("airports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/airports/1/edit").should route_to("airports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/airports").should route_to("airports#create")
    end

    it "routes to #update" do
      put("/airports/1").should route_to("airports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/airports/1").should route_to("airports#destroy", :id => "1")
    end

  end
end
