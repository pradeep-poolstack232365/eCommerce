class UsersController < ApplicationController
     before_action :authenticate_request, except: [:create,:index]
		 before_action :set_user, only: [:show, :destroy]

    
	def index
		# byebug
		@users = User.all
		render json: @users, each_serializer: UserSerializer
	end

	def show
		render json: @user, each_serializer: UserSerializer
	end

	def create
		# debugger
		@user = User.new(user_params)

		if @user.save
			render json: @user, each_serializer: UserSerializer, status: :created
		else
			render json: {errors: @user.errors.full_messages}, 
			status: :unprocessable_entity
		end
	end

	def update
        # debugger
        @user = User.find_by(id: params[:id])
		if @user&.update(user_params)
			render json:{notice: "user is updated successfully"}
		else
			render json:{notice: "something went wrong"}
        end
    end


	def destroy
		# debugger
		@user = User.find_by(id: params[:id])
		if @user.destroy
			render json: {notice: "user is deleted successfully"}
    else
         	render json: {message: "something went wrong"}
    end
	end

    private

    def user_params
    	params.permit(:first_name, :last_name, :email, :phone, :password)
    end

    def set_user
          @user = User.find(params[:id])
          rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

end
