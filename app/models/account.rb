class Account < ActiveRecord::Base
  ACCOUNT_STATUSES = ['active', 'closed']

  attr_accessible :name, :status

  validates :name, :status, :presence => true
  validates :status, :inclusion => { :in => ACCOUNT_STATUSES }

  belongs_to :user

end
