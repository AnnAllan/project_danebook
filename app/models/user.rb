class User < ApplicationRecord
  has_secure_password
  before_create :generate_token
  after_create :build_profile, if: Proc.new{self.profile.nil?}

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts


  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  accepts_nested_attributes_for :profile, :reject_if => :all_blank

  validates :first_name, :last_name, :presence => true,
                                    :length => {:in => 1..30},
                                    :format => {:with => /[a-zA-Z]+/}

  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /([\w\.-]+)@([\w\.-]+)\.([a-z\.]{2,6})/ }

  validates :password,
           :length => {:in => 6..24},
           :allow_nil => true

  def friends
    friended_users
  end

  def match_like(params)
    likes.where("likable_id = ? AND likable_type = ?", params[:likable_id], params[:likable_type]).first
  end

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
