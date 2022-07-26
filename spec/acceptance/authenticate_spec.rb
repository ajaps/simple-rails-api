require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Authenticate" do
  let!(:user) { User.create(email: "frank@email.com", first_name: "frank", last_name: "ajaps", password: "password")}

  post "api/v1/login" do
    parameter :email, 'The user\'s email', required: true
    parameter :password, 'The user\'s password', required: true
    
    example "retrieve api token/key" do
      params = {
        email:       "frank@email.com",
        password:    "password",
      }

      do_request(params)

      body = JSON.parse(response_body)

      expect(body['token']).to be_present
      expect(body['email']).to eq(user.email)
      expect(status).to eq 200
    end
  end
end