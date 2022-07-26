require 'rails_helper'

RSpec.describe "Api::V1::Accounts", type: :request do
  let!(:user) { User.create(email: "frank@email.com", first_name: "frank", last_name: "ajaps", password: "password")}
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  describe "GET /create" do
    it "returns http success" do
      params = {
        first_name:  "franklin",
        last_name:   "ajaps",
        email:       "frank02@email.com",
        password:    "password",
      }

      post "/api/v1/accounts", params: params

      response_body = JSON.parse(response.body)

      expect(response_body['data']['password_digest']).to be_present
      expect(response_body['email']).to eq(params['email'])
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      params = {
        email:       "different_email@email.com",
        password:    "password",
      }

      put "/api/v1/accounts/update", params: params, headers: { :Authorization =>  token}

      response_body = JSON.parse(response.body)

      expect(response_body['email']).to eq(params['email'])
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/accounts", headers: { :Authorization =>  token}

      response_body = JSON.parse(response.body)

      expect(response_body['email']).to eq(user.email)
      expect(response_body['first_name']).to eq(user.first_name)
      expect(response_body['last_name']).to eq(user.last_name)
      expect(response).to have_http_status(:success)
    end
  end
end
