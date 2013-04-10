class MailPreview < MailView
  # Pull data from existing fixtures
  def invitation
    account = Account.first
    inviter, invitee = account.users[0, 2]
    Notifier.invitation(inviter, invitee) 
  end

  # Factory-like pattern
  def welcome
    user = User.first
    mail = BudgetMailer.confirmation_instructions(user)
    #user.destroy
    mail
  end

  # Stub-like
  def forgot_password
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    mail = UserMailer.forgot_password(user)
  end
end