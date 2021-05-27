class Api::V1::LeadController < ApplicationController
    before_action :authorize_request, except: [:create]
    before_action :get_authorize_user, only: [:create]

    def create    
        unless @current_user
            client = User.new(lead_params)
            client.skip_password_validation = true
            if client.save
                @current_user = client

                # TODO The user can have two leads in the same project
                lead = Lead.new(project_id: params[:project_id], user_id: @current_user.id)
        
                if lead.save
                    # TODO Email delivery
                    render json: lead, status: :ok
                else
                    render json: { errors: lead.errors.messages }, status: :unprocessable_entity
                end

            else
                render json: { errors: client.errors.messages }, status: :unprocessable_entity
            end
        end
    
    end

    def retrieve
        project = Project.find(params[:project_id])
        render json: project.leads, status: :ok
    end
    
    def lead_params
        params.permit(
            :first_name, :last_name, :phone, :email
        )
    end

end
