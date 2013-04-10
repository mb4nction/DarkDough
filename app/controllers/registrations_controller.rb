class RegistrationsController < Devise::RegistrationsController
	include ApplicationHelper
	def create
		user = User.find_by_email(params[:user][:email])
		if user!=nil
			flash.now[:alert] = "The email address exists already. Please try again with another."
			flash.delete :recaptcha_error
			build_resource
			clean_up_passwords(resource)
			render :new
			return
		end
		phone_number = params[:user][:phone_number]
		sms = params[:user][:sms]
		is_success = true

		if !verify_recaptcha
			flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
			flash.delete :recaptcha_error
			is_success = false
		end
		
		if is_success
			if !send_sms(phone_number, sms)
				flash.now[:alert] = "There was an error while sending the sms to your phone. Please check again."
				flash.delete :recaptcha_error
				is_success = false
			end
		end
		
		if is_success == false
			build_resource
			clean_up_passwords(resource)
			render :new
		else
			flash[:is_signedup] = true
			user = User.new(params[:user])
			user.save
			redirect_to root_path
		end
	end
end
