class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  CATEGORIES = YAML.load_file("#{Rails.root}/config/categories.yml")

  validates :category, :amount, :description, :presence => true
  validates :amount, :numericality => true
  validates :category, :inclusion => { :in => CATEGORIES }

  scope :by_category, lambda { |q| {:conditions => ["category like :q", {:q => "%#{q}%"}]} }
  scope :spending_transactions, lambda { where("category != ?", "income") }
  scope :in_last_month, :conditions => ["created_at >= ?", 1.month.ago]

  def amounts_sum(category)
    by_category(category).map(&:amount).sum
  end

  def self.search(start_date, end_date, category)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day])
    else
      if category == 'spending'
        spending_transactions.in_last_month
      else
        by_category("Income").in_last_month
      end
    end
  end

  def self.find_amount(start_date, end_date)
    if start_date && !(start_date == '')
      end_date == '' ? end_date = Time.now.utc : end_date
      find(:all, :conditions => ['created_at >= ? AND created_at <= ?', start_date, end_date.to_date + 1.day]).map{|transaction| transaction.amount}.sum
    else
      in_last_month.find(:all).map{|transaction| transaction.amount}.sum
    end
  end
end
