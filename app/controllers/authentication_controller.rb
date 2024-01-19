class AuthenticationController < ApplicationController
     
	def login
		@user = User.find_by_email(params[:email])
		if @user&.authenticate(params[:password])
			token = JsonWebToken.encode(user_id: @user.id)
			render json: {token: token} , status: :ok 

		else

			render json: {error: "unauthorized"}, status: :unauthorized
		end

	end
	# def login
	#       # @user = User.find_by(email: params[:email])
	#       # unless @user.present?
	#         # debugger
	#         @user = User.find_by(username: params[:email])
	#         unless @user.present?
	#           render json:{error:"user not found"}
	#         end
	#       end
	#     # else
	#        # @user = User.find_by_username(params[:loginn])
	#     # end
	#   if @user.present?
	#     if @user.authenticate(params[:password])
	#       token = JsonWebToken.encode(user_id: @user.id)
	#       time = Time.now + 24.hours.to_i

	#       render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
	#                      username: @user.username }, status: :ok
	#     else
	#       render json: { error: 'unauthorized' }, status: :unauthorized
	#     end
	#   end
	#   end
	  # private
	  # def login_params
	  #   params.permit(:email_or_username, :password)
	  # end
end
