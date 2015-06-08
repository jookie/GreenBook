require "rails_helper"

#http://docs.seattlerb.org/minitest/
#https://www.relishapp.com/rspec/docs/gettingstarted
#http://commandercoriander.net/blog/2014/01/04/test-driving-a-json-api-in-rails/
RSpec.describe AppointmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/appointments").to route_to("appointments#index")
    end

    it "routes to #show" do
      expect(:get => "/appointments/1").to route_to("appointments#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/appointments").to route_to("appointments#create")
    end

    it "routes to #update" do
      expect(:put => "/appointments/1").to route_to("appointments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/appointments/1").to route_to("appointments#destroy", :id => "1")
    end

  end
end
