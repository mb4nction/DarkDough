class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    dashboard_path
  end


  def http_get(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    #request.basic_auth("","")
    http.request(request).body
  end

  def http_post(url,content)
    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = content
    #request.basic_auth("","")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request).body
  end


	def send_sms_nexmo(phone_number,sms)
		phone_number = phone_number.to_s.gsub(/[^0-9]/i,'')
		begin
			File.open("./sms.txt","a") do |f|
				a = {:to => phone_number, :sms => sms}
				f.puts a.inspect
			end
			#nexmo = ::Nexmo::Client.new('5915f34a', 'c9c9faa9')
			#nexmo.send_message!({:to => phone_number, :from => 'Budget247', :text => "Welcome to budget247!\nHere is your code.\n\n"+sms})
			
			return sms
		rescue Exception=>e
			return nil
		end
	end


	def send_sms(phone_number,sms)
    return 247
		require 'twilio-ruby'
		phone_number = phone_number.to_s.gsub(/[^0-9]/i,'')
		begin
			File.open("./sms_twilio.txt","a") do |f|
				a = {:to => phone_number, :sms => sms}
				f.puts a.inspect
			end
			account_sid = "AC9dee5a56e31e6b38730d4632e2ae8701"
			auth_token = "2fe08a948134d4183c86e159691d4db3"
			client = Twilio::REST::Client.new account_sid, auth_token
			from = "+18024310019"
			client.account.sms.messages.create(
				:from => from,
				:to => "+#{phone_number}",
				:body => "Budget 247 is now ready for you. Your supersecret code is #{sms}."
			) 
			return sms
		rescue Exception=>e
			return nil
		end
	end





  protected

  def layout_by_resource
    if devise_controller?
      "public"
    else
      "application"
    end
  end
end
