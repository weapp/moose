# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  role_id                :integer
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username

  belongs_to :role
  has_many :posts
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  before_create :set_default_role

  scope :with_role, lambda { |role| includes(:role).where('roles.name' => role) }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :provider, :uid
  # attr_accessible :title, :body

  def admin?
    auth == "admin"
  end

  def approved?
    !!approved
  end

  def approved
    auth != "unapproved"
  end

  def auth
    @auth ||= role.try(:name)
  end

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def to_s
    #"#{username} <#{email}>"
    "#{username}"
  end

  def self.find_for_oatuh_uid(auth)
    User.where(provider: auth.provider, uid: auth.uid).first
  end

  def self.find_for_oauth_mail(auth)
    user = User.where(email: auth.info.email).first
    if user
      user.update_attributes(provider: auth.provider, uid: auth.uid)
      user.save
    end
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_for_oatuh_uid(auth) || User.find_for_oauth_mail(auth)
    user ||= User.create(
                         username: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: Devise.friendly_token[0,20]
                         )  
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  private
    def set_default_role
      self.role ||= Role.find_by_name('unapproved')
    end

end
