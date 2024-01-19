class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

	 private

	
	def authenticate_request
	    header = request.headers['token']
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
end
