Factory.define :user do |user|
  user.first_name            "Johny"
  user.last_name             "Nesh"
  user.email                 "johny@mailinator.com"
  user.country               "Albania"
  user.phone_number          "0123456789"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.define :account do |account|
  account.name   "Johny's account"
  account.status "active"
end

Factory.define :transaction do |transaction|
  transaction.category "Phone"
  transaction.description "Some description"
  transaction.amount "123"
  transaction.note "Some note"
end

Factory.define :budget do |budget|
  budget.category "Phone"
  budget.period "1 month"
  budget.amount "1234"
end

Factory.define :bank do |bank|
  bank.name   "Union bank"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
