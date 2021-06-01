class ApplicationController < ActionController::API

    def not_found
        render json: { error: 'not_found' }
    end
    
    def get_authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
    
    def get_authorize_user
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        begin
            decoded = JsonWebToken.decode(token)
            @current_user = User.with_role(:admin).where(:id => decoded[:user_id]).first
        rescue JWT::DecodeError => e
            @current_user = nil
        end
    end

end
