module BudgetsHelper
  def budget_periods
    Budget::PERIODS.collect{ |p| pluralize(p, "month")}
  end
end
