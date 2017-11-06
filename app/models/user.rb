class User < ApplicationRecord
  has_secure_password
  before_create :generate_token
  after_create :build_profile, if: Proc.new{self.profile.nil?}

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts

  validates :password,
           :length => {:in => 6..24},
           :allow_nil => true

  def full_name
    self.first_name + " " + self.last_name
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
