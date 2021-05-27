class Project < ApplicationRecord

    belongs_to :user
    has_many :leads
    has_many :users_by_leads, through: :lead, source: :user
    
    extend FriendlyId 

    friendly_id :generate_project_slug, use: :slugged
    def generate_project_slug
        "#{:city}-#{:type_project}-#{:title}"
    end

    validate    :area_validation

    validates   :type_project,
                inclusion: { 
                    in: ['R', 'C', 'I', 'L'],
                    message: 'opción no valida'
                }

    validates   :title,
                uniqueness: true

    validates   :email,
                format: { with: URI::MailTo::EMAIL_REGEXP }
    # TODO Email list

    validates   :title,
                :type_project,
                :city,
                :address,
                :price,
                :private_area,
                :building_area,
                :email,
                :user,
                presence: true

    validates   :has_vis,
                :has_parking,
                inclusion: { 
                    in: [ true, false ]
                }

    validates   :price,
                :private_area,
                :building_area,
                numericality: {
                    greater_than: 0
                }

    validates   :bathrooms,
                presence: false,
                numericality: {
                    greater_than: 0,
                    allow_nil: true
                }

    def area_validation
        if private_area and building_area
            if private_area > building_area
                errors.add(:private_area, "El área privada es mayor al área construida")
                errors.add(:building_area, "El área construida menor al área privada")
            end
        end
    end

end
