desc "Add test users for fast signing in"
namespace :db do
  task :seed => :environment do
    Rake::Task['db:reset'].invoke

    User.create!(:first_name => "Eugene", :last_name => "K.",
                 :email => "user1@mailinator.com", :country => "Ukraine", :phone => "0123456789",
                 :password => "epyfnm", :password_confirmation => "epyfnm")

    Rake::Task['db:reset'].invoke
    3.times do |n|
      Bank.create!(:name => "Bank #{n+1}")
    end
  end
end
