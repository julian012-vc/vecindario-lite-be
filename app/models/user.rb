class User < ApplicationRecord
  attr_accessor :skip_password_validation

  rolify

  extend FriendlyId 

  friendly_id :friendly_field, use: :slugged
  def friendly_field
    "#{first_name}-#{last_name}"
  end
  
  has_many :project
  has_many :lead
  has_many :leads, through: :lead, source: :project
  
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable
  
  validates :email,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
  # TODO Validate email

  validates :first_name,
            :last_name,
            :phone,
            presence: true
  
  validates :password, presence: false, on: :create

  def password_required?
    return false if skip_password_validation
    super
  end

end
