class Api::V1::AuthenticationController < ApplicationController
    before_action :get_authorize_request, except: [:login, :create]
    before_action :get_admin_user_by_email, only: [:create, :login]

    def login
        if @user and @user&.valid_password?(login_params[:password])
            render json: { token: JsonWebToken.encode(user_id: @user.id) }, status: :ok
        else
            render json: { error: { email: ['El correo o la contraseña no son correctos'] }}, status: :unauthorized
        end
    end 

    def create
        if @user
            render json: { errors: { email: ['El correo ya tiene una cuenta asociada'] }}
        else
            new_user = User.new(user_params)
            new_user.add_role :admin
            if new_user.save
                render json: { token: token = JsonWebToken.encode(user_id: @user.id) }, status: :ok
            else
                render json: { errors: user.errors.messages }, status: :unprocessable_entity
            end
        end
    end

    def retrieve
        render json: @current_user, status: :ok
    end

    private

    def login_params
        params.permit(:email, :password)
    end

    def user_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
    end

    def get_admin_user_by_email
        @user = User.with_role(:admin).where(:email => login_params[:email]).first
    end
end
