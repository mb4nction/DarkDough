module TrendsHelper
  def Transaction.search(start_date, end_date, category)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day])
    else
      if category == 'spending'
        spending_transactions
      else
        by_category("Income")
      end
    end
  end
end
