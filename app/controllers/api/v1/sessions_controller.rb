# == Api Session Authentication (log in/ logout)

class Api::V1::SessionsController < Api::ApiController

	def create
		user_email = request.headers['X-API-EMAIL'].presence
		user_password = request.headers['X-API-PASS'].presence

		user = user_email.present? && User.find_by_email(user_email)
		if user
			if user.valid_password?(user_password)
				sign_in user, store: false
				user.generate_auth_token
				user.save

				render json: {user: user}, :status => :created
			else
				render json: {errors: "Invalid email or password"}, status: 422
			end
		else
			render json: {errors: "User not found"}, status: 422
		end
	end

	def destroy
		respond_to do |format|
			format.html{
				super
			}
			format.json{
				user = User.find_by_auth_token(request.headers['Authorization'])
				if user
					user.generate_auth_token
					user.save
					render :json => {:message => 'Session Ended'}, :success => true, :status => 204
				else
					render :json => {:message => 'Invalid Token'}, :status => 404
				end
			}
		end
	end

	def invalid_login_attempt
		warden.custom_failure!
		render :json => {:errors => ["Invalid email or password"]}, :success => false, :status => :unauthorized
	end
end
