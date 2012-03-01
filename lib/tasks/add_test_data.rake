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
    end


    Budget.create!(:category => Transaction::CATEGORIES[1], :amount => 25, :period => "1", :user_id => "1")
    Budget.create!(:category => Transaction::CATEGORIES[2], :amount => 50, :period => "1", :user_id => "1")
    Budget.create!(:category => Transaction::CATEGORIES[3], :amount => 75, :period => "1", :user_id => "1")

    b04 = Budget.create!(:category => Transaction::CATEGORIES[4], :amount => 100, :period => "1", :user_id => "1")
    b04.created_at = Date.today - 20.days
    b04.save
    b05 = Budget.create(:category => Transaction::CATEGORIES[5], :amount => 125, :period => "1", :user_id => "1")
    b05.created_at = Date.today - 15.days
    b05.save

    Budget.create!(:category => Transaction::CATEGORIES[6], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    Budget.create!(:category => Transaction::CATEGORIES[7], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b08 = Budget.create!(:category => Transaction::CATEGORIES[8], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b08.created_at = Date.today + 2.days
    b08.save
    b09 = Budget.create(:category => Transaction::CATEGORIES[9], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b09.created_at = Date.today - 32.days
    b09.save
    b10 = Budget.create(:category => Transaction::CATEGORIES[10], :amount => 25, :period => "1",
                   :user_id => "1", :start => Time.now - 2.days)
    b10.created_at = Date.today - 1.month
    b10.save

    Account.create!(:name => 'Test account', :status => 'active', :bank_id => '3', :amount => 1000, :user_id => 1)
  end
end
