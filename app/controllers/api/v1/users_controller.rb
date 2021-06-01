class Api::V1::UsersController < ApplicationController
    before_action :get_authorize_request, except: :create
    before_action :find_user, except: %i[create index]

    def register_contact
        @user = User.new(contact_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.messages }, status: :unprocessable_entity
        end
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
