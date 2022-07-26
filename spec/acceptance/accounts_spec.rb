require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Accounts" do
  let!(:user) { User.create(email: "frank@email.com", first_name: "frank", last_name: "ajaps", password: "password")}
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  post "api/v1/accounts" do
    parameter :first_name, 'The user\'s first name', required: true
    parameter :last_name, 'The user\'s last name', required: true
    parameter :email, 'The user\'s email', required: true
    parameter :password, 'The user\'s password', required: true
    
    example "create account" do
      params = {
        first_name:  "franklin",
        last_name:   "ajaps",
        email:       "frank02@email.com",
        password:    "password",
      }

      do_request(params)

      body = JSON.parse(response_body)

      expect(body['data']['password_digest']).to be_present
      expect(body['email']).to eq(params['email'])
      expect(status).to eq 201
    end
  end

  put "api/v1/accounts" do
    header 'Authorization', :token

    parameter :email, 'The user\'s email', required: true
    parameter :password, 'The user\'s password', required: true
    parameter :token, "Authentication Header Token", required: true

    example "update account" do
      params = {
        email:       "frank@email.com",
        password:    "password11",
      }

      do_request(params)

      body = JSON.parse(response_body)

      expect(body['email']).to eq(params['email'])
      expect(status).to eq 200
    end
  end

  get "api/v1/accounts" do
    header 'Authorization', :token

    parameter :email, 'The user\'s email', required: true
    parameter :password, 'The user\'s password', required: true
    parameter :token, "Authentication Header Token", required: true

    example "retrieve account details" do
      do_request(params)

      body = JSON.parse(response_body)

      expect(body['email']).to eq(user.email)
      expect(body['first_name']).to eq(user.first_name)
      expect(body['last_name']).to eq(user.last_name)
      expect(status).to eq 200
    end
  end
end