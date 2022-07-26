require 'rails_helper'

RSpec.describe "Api::V1::Authenticates", type: :request do
  let!(:user) { User.create(email: "frank@email.com", first_name: "frank", last_name: "ajaps", password: "password")}
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  describe "GET /login" do
    it "returns http success" do
      post "/api/v1/login", params: {
        email:       user.email,
        password:    "password",
      }

      response_body = JSON.parse(response.body)

      expect(response_body['token']).to be_present
      expect(response_body['email']).to eq(user.email)
      expect(response).to have_http_status(:success)
    end
  end
end
