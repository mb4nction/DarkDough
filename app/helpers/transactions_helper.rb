module TransactionsHelper
  def percentage(amount)
    (sprintf("%.3f", amount).to_f * 100)
  end

  def transactions_categories(transactions)
    transactions.map{ |transaction| transaction.category }.uniq
  end

  def transactions_months(transactions)
    transactions.map{ |transaction| transaction.created_at.month }.uniq.sort
  end

  def transactions_descriptions(transactions)
    transactions.map{ |transaction| transaction.description }.uniq.sort
  end

  def categorized_income(transactions)
    income = []
    (transactions_categories(transactions)).each do |category|
      income << [category, transactions.find_all{|tr| tr.category == category}.map(&:amount).sum.to_f]
    end
    income = Hash[*income.flatten!]
  end

  def categorized_spending(transactions)
    spending = []
    (transactions_categories(transactions)-['Income']).each do |category|
      spending << [category, transactions.find_all{|tr| tr.category == category}.map(&:amount).sum.to_f]
    end
    spending = Hash[*spending.flatten!]
  end

  def monthly_income(transactions)
    income = []
    (transactions_months(transactions)).each do |month|
      income << [month, transactions.find_all{ |tr| tr.created_at.month == month}.map(&:amount).sum.to_f]
    end
    income = Hash[*income.flatten!]
  end

  def monthly_spending(transactions)
    spending = []
    (transactions_months(transactions)).each do |month|
      spending << [month, transactions.find_all{ |tr| tr.created_at.month == month}.map(&:amount).sum.to_f]
    end
    spending = Hash[*spending.flatten!]
  end

  def merchanized_income(transactions)
    income = []
    (transactions_descriptions(transactions)).each do |description|
      income << [description, transactions.find_all{ |tr| tr.description == description }.map(&:amount).sum.to_f]
    end
    income = Hash[*income.flatten!]
  end

  def merchanized_spending(transactions)
    spending = []
    (transactions_descriptions(transactions)).each do |description|
      spending << [description, transactions.find_all{ |tr| tr.description == description }.map(&:amount).sum.to_f]
    end
    spending = Hash[*spending.flatten!]
  end
end
