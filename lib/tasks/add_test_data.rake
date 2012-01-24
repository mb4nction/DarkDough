desc "Add test users for fast signing in"
namespace :db do
  task :add_users => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:first_name => "Eugene", :last_name => "K.",
                 :email => "user1@mailinator.com", :country => "Urkaine", :phone => "0123456789",
                 :password => "epyfnm", :password_confirmation => "epyfnm")

     User.create!(:first_name => "Mark", :last_name => "B.",
                  :email => "user2@mailinator.com", :country => "Great Britain", :phone => "0123456789",
                  :password => "password", :password_confirmation => "password")
  end
end
