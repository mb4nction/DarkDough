class Bank < ActiveRecord::Base
  attr_accessible :name, :api_key, :api_secret, :website
  has_many :accounts
  belongs_to :user

  has_attached_file :thumbnail, styles: { medium: "65x65#", small: "40x40#" },
                             default_url: 'default_img/anonymous.png',
                             path: ":rails_root/public/system/:class/:id/:style/:filename",
                             url: "/system/:class/:id/:style/:filename"  
  validates :name, :presence => true
  validates :api_key, :presence => true
  validates :api_secret, :presence => true
  validates :website, :presence => true
end
