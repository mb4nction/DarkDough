module TransactionsHelper
  def percentage(amount)
    (sprintf("%.3f", amount).to_f * 100)
  end
end
