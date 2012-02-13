class User < ActiveRecord::Base
  attr_accessor   :tos_confirmation

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :phone_number, :email,
                  :password, :password_confirmation, :country, :tos_confirmation,
                  :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :country, :presence => true
  validates :first_name, :last_name, :length => { :maximum => 30 }

  validates :tos_confirmation, :acceptance => true, :if => :new_record?
  validates :country, :inclusion => { :in => Carmen::country_names }

  has_many :acumen_tests
  has_many :answers, :through => :acumen_tests
  has_many :accounts
  has_many :transactions
end
