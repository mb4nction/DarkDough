module TransactionsHelper
  def percentage(amount)
    (sprintf("%.3f", amount).to_f * 100)
  end

  def categorized_income(transactions)
    income = ['Income', transactions.by_category("Income").map(&:amount).sum.to_f]
  end

  def transactions_categories(user)
    user.transactions.map{ |transaction| transaction.category }.uniq!
  end

  def categorized_spending(transactions, user)
    spending = []
    (transactions_categories(user)-['Income']).each do |category|
      spending << [category, transactions.by_category(category).map(&:amount).sum.to_f]
    end
    spending = Hash[*spending.flatten!]
  end
end
