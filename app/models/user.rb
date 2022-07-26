class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation :email_to_lower_case

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def email_to_lower_case
    self.email = email&.downcase
  end
end
