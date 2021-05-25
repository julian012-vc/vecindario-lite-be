class Api::V1::AuthenticationController < ApplicationController
    before_action :authorize_request, except: [:login, :create]

    ADMIN = 'A'

    def login
        @user = User.find_by(email: login_params[:email], type_user: ADMIN)
        print login_params
        if @user&.valid_password?(login_params[:password])
            render json: { token: JsonWebToken.encode(user_id: @user.id) }, status: :ok
        else
            render json: { error: { email: ['El correo o la contraseña no son correctos'] }}, status: :unauthorized
        end
    end 

    def create
        if User.where(:email => user_params['email'], :type_user => ADMIN).any?
            render json: { errors: { email: ['El correo ya tiene una cuenta asociada'] }}
        else
            @user = User.new(user_params)
            if @user.save
                render json: { token: token = JsonWebToken.encode(user_id: @user.id) }, status: :ok
            else
                render json: { errors: @user.errors.messages }, status: :unprocessable_entity
            end
        end
    end

    private

    def login_params
        params.permit(:email, :password)
    end

    def user_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone, :type_user)
    end

end
