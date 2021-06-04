class Api::V1::UsersController < ApplicationController
    before_action :get_authorize_request, only: [:user_projects]
    before_action :get_authorize_user, only: [:user_projects]

    def register_contact
        @user = User.new(contact_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.messages }, status: :unprocessable_entity
        end
    end

    def user_projects
        render json: @current_user.project, status: :ok
    end

    # GET /users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    private

    def contact_params
        params.permit(
          :first_name, :last_name, :email, :phone, :type_user
        )
    end

end
