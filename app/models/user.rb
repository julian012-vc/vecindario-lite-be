class User < ApplicationRecord

  extend FriendlyId 

  friendly_id :friendly_field, use: :slugged
  def friendly_field
    "#{first_name}-#{last_name}"
  end
  
  has_many :project
  
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable
  
  validates :email,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }

  validates :first_name,
            :last_name,
            :phone,
            :type_user,
            presence: true

end
