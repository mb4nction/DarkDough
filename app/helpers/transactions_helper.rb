module TransactionsHelper
  def percentage(amount)
    (sprintf("%.3f", amount).to_f * 100)
  end

  def categorized_income(transactions)
    income = ['Income', transactions.find_all{|tr| tr.category == "Income"}.map(&:amount).sum.to_f]
  end

  def transactions_categories(transactions)
    transactions.map{ |transaction| transaction.category }.uniq!
  end

  def categorized_spending(transactions)
    spending = []
    (transactions_categories(transactions)-['Income']).each do |category|
      spending << [category, transactions.find_all{|tr| tr.category == category}.map(&:amount).sum.to_f]
    end
    spending = Hash[*spending.flatten!]
  end
end
