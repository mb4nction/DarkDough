class Budget < ActiveRecord::Base
  belongs_to :user

  validates :category, :amount, :period, :presence => true
  validates :amount, :numericality => true

  scope :income, where(:category => 'income')
  scope :spending, lambda { where("category != ?", "income") }

  def self.search(start_date, end_date)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Date.today.to_s : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at<= ?', start_date, end_date])
    else
      all
    end
  end
end
