module GoalsHelper
  def check_account_dedicated(account)
    user_accounts_ids = []
    current_user.goals.each do |goal|
      user_accounts_ids << goal.account_ids
    end
    user_accounts_ids = user_accounts_ids.uniq!.flatten!
    user_accounts_ids.include?(account.id) ? true : false
  end
end
