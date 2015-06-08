require 'rails_helper'

#redundent dov to refactor
RSpec.describe "Appointments", type: :request do
  describe "GET /appointments" do
    it "Checks that HTTP status is OK" do
      get appointments_path
      expect(response).to have_http_status(200)
    end
  end
end

