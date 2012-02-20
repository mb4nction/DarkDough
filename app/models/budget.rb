class Budget < ActiveRecord::Base
  attr_accessible :category, :amount, :period, :start, :user_id
  belongs_to :user

  validates :category, :amount, :period, :presence => true
  validates :amount, :period, :numericality => true

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
