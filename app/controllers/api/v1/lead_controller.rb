class Api::V1::LeadController < ApplicationController
    before_action :get_authorize_request, except: [:create]
    before_action :get_authorize_user, only: [:create]
    before_action :get_client_to_lead, only: [:create]

    def create
        # TODO The user can have two leads in the same project
        lead = Lead.new(project_id: params[:project_id], user_id: @client_lead.id)

        if lead.save
            LeadMailer.delivery_lead_email(Project.find(params[:project_id]), @client_lead).deliver
            render json: lead, status: :ok
        else
            render json: { errors: lead.errors.messages }, status: :unprocessable_entity
        end
    
    end

    def retrieve_project_leads
        project = Project.find(params[:project_id])
        render json: project.leads, status: :ok
    end

    private
    
    def lead_params
        params.permit(
            :first_name, :last_name, :phone, :email, :project_id
        )
    end

    def get_client_to_lead
        if @current_user
            @client_lead = @current_user
        else
            client = User.new(lead_params.except(:project_id))
            client.skip_password_validation = true
            if client.save
                @client_lead = client
            else
                render json: { errors: client.errors.messages }, status: :unprocessable_entity
            end
        end
    end

end
