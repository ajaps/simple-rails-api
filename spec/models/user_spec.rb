require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
      first_name: "franklin",
      last_name: "ajaps",
      email: "frank@email.com",
      password: "password",
    }
  }

  describe "validations" do
    let(:user) { User.new(valid_attributes) }
    
    before do
      User.create(valid_attributes)
    end

    it "requires an first_name" do   
      expect(user).to validate_presence_of(:first_name)
    end

    it "requires an last_name" do   
      expect(user).to validate_presence_of(:last_name)
    end

    it "requires an email" do   
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "FRANKLIN@EMAIL.COM"
      expect(user).to validate_uniqueness_of(:email).case_insensitive
    end

    it "requires the email address to look like an email" do
      user.email = "franklin"
      expect(user).to_not be_valid
    end
  end

  describe "#full_name" do
    let(:user) { User.new(valid_attributes) }

    it "returns a combination of first_name and last_name" do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
