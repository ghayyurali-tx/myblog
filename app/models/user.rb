class User < ApplicationRecord
  #before_create :confirmation_token
  has_secure_password
  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: { case_sensitive: true } ,
            length: { minimum: 3 }
  validates_uniqueness_of :email , except: [:edit]

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil

  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
