class User < ApplicationRecord
  #before_create :confirmation_token
  has_secure_password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_one_attached :avatar
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            dimension: { width: { min: 300, max: 1920 },
                         height: { min: 300, max: 1080 }, message: 'is not given between dimension. Please Provide image with dimensions between [300-1920]x[300-1080]' }


  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/i, message: "can only be letters." }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_confirmation_of :password, confirmation: { case_sensitive: true }, on: :create
  validates_length_of :password, minimum: 3, on: :create
  validates_uniqueness_of :email , except: [:edit]

  def self.search(search)
    #debugger
    if search
      User.where("lower(name) LIKE ?","%#{search.downcase}%")
#   # debugger
#   # if article
#   #   article
    else
      User.all
    end
    # else
    #   Article.all
    #
    # end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil

  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def update_with_token!
    update_column(:token, generate_token)
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end
