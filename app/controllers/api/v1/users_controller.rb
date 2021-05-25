class Api::V1::UsersController < ApplicationController
    before_action :authorize_request, except: :create

    # POST /users
    def create
        @user = User.new(user_params)
        if @user.save
        render json: @user, status: :created
        else
        render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # GET /users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

end
