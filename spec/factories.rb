Factory.define :account do |account|
  account.name   "Johny's account"
  account.status "active"
  account.amount "1000"
end

Factory.define :bank do |bank|
  bank.name   "Union bank"
end

Factory.define :budget do |budget|
  budget.category "Phone"
  budget.period "1 month"
  budget.amount "1234"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :goal do |goal|
  goal.title "Factory goal"
  goal.category Goal::GOAL_CATEGORIES[0]
  goal.amount '10000'
  goal.contribution '200'
  goal.planned_date Date.today + 1.year
end

Factory.define :transaction do |transaction|
  transaction.category "Phone"
  transaction.description "Some description"
  transaction.amount "123"
  transaction.note "Some note"
end

Factory.define :user do |user|
  user.first_name            "Johny"
  user.last_name             "Nesh"
  user.email                 "johny@mailinator.com"
  user.country               "Albania"
  user.phone_number          "0123456789"
  user.password              "password"
  user.password_confirmation "password"
end
