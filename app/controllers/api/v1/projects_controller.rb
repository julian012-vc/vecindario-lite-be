class Api::V1::ProjectsController < ApplicationController
    before_action :get_authorize_request, except: [:list, :retrieve]
    
    def create
        @project = Project.new(project_params)
        if @project.save
            render json: @project, status: :created
        else
            render json: { errors: @project.errors.messages }, status: :unprocessable_entity
        end
    end

    def retrieve
        @project = Project.find_by_slug(params[:id])
        render json: @project, status: :ok
    end

    def update
        @project = Project.find(params[:id])
        @project.attributes = project_params
        if @project.save
            render json: @project, status: :accepted
        else
            render json: { errors: @project.errors.messages }, status: :unprocessable_entity
        end
    end

    def leads
        @project = Project.find_by_slug(params[:id])
        if @project
            @user_leads = []
            @project.leads.order("created_at DESC").each do |lead|
                user = lead.user
                user.created_at = lead.created_at
                @user_leads.push(user)
            end
            render json: @user_leads, status: :ok
        else
            render json: { errors: 'Not Found' }, status: :unprocessable_entity
        end
    end

    # TODO Refactor code
    def list
        query_params = request.query_parameters
        if query_params[:filter].present?
            filter = query_params[:filter]
            @projects = Project.where("title ILIKE ? OR city ILIKE ?", "%#{filter}%", "%#{filter}%")
        else
            @projects = Project.all
        end
        render json: @projects, status: :ok
    end

    private

    def project_params
        params.permit(
            :title, :type_project, :city, :address, :price,
            :private_area, :building_area, :has_vis, :has_parking,
            :email, :bathrooms, :user_id
        )
    end
end
