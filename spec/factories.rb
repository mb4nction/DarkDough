Factory.define :user do |user|
  user.first_name            "Johny"
  user.last_name             "Nesh"
  user.email                 "johny@mailinator.com"
  user.country               "Albania"
  user.phone_number          "0123456789"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
