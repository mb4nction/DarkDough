class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone_number, :email,
                  :password, :password_confirmation, :country, :tos_confirmation
  attr_accessor   :tos_confirmation

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :first_name, :last_name, :country, :presence => true
  validates :first_name, :last_name, :length => { :minimum => 0, :maximum => 128 }

  validates :tos_confirmation, :acceptance => true, :if => :new_record?
end
