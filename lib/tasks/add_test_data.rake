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

      Transaction.create!(:description => "The #{n+1} 'phone' category transactions.",
                          :category => "Phone", :amount => 10*(n+1), :user_id => "1")
      Transaction.create!(:description => "The #{n+1} 'income' category transactions.",
                          :category => "Income", :amount => 100*(n+1), :user_id => "1")
      Budget.create!(:category => "Income", :amount => 50*(n+1), :period => "1", :user_id => "1")
      Budget.create!(:category => "Medicine", :amount => 25*(n+1), :period => "1",
                     :user_id => "1", :start => Time.now - 2.days)
    end
  end
end
