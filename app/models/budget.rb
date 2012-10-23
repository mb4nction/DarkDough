class Budget < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :category, :amount, :period, :start, :user_id, :tag_list
  belongs_to :user
  
  validates :category, :amount, :period, :presence => true
  validates :amount, :period, :numericality => true

  scope :income, where(:category => 'income')
  scope :spending, lambda { where("category != ?", "income") }
  scope :in_this_month, :conditions => ["created_at >= ?", Date.today.beginning_of_month]


  def self.search(start_date, end_date)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day])
    else
      in_this_month
    end
  end
end
