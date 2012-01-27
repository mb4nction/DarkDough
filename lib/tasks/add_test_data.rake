desc "Add test users for fast signing in"
namespace :db do
  task :add_users => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:first_name => "Eugene", :last_name => "K.",
                 :email => "user1@mailinator.com", :country => "Ukraine", :phone => "0123456789",
                 :password => "epyfnm", :password_confirmation => "epyfnm")

     User.create!(:first_name => "Vadim", :last_name => "Kondratiev",
                  :email => "vvk@anahoret.com", :country => "Ukraine", :phone => "0502221126",
                  :password => "password", :password_confirmation => "password")

     User.create!(:first_name => "Mark", :last_name => "Bell",
                  :email => "411bellerophon@gmail.com", :country => "United Kingdom", :phone => "07552303894",
                  :password => "password", :password_confirmation => "password")
  end
end
