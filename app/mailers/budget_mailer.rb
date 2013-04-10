class BudgetMailer < Devise::Mailer
  #layout 'mainemail'
	default from: "WarmWelcome@budget247.com"
	def confirmation_instructions(record)
		super
	end
end