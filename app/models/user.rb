class User < ApplicationRecord
  #before_create :confirmation_token
  has_secure_password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/i, message: "can only be letters." }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_confirmation_of :password, confirmation: { case_sensitive: true } 
  validates_length_of :password, minimum: 3
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
