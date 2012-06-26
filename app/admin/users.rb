ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :last_sign_in_at
    column :created_at
    column :updated_at
    column :first_name
    column :last_name
    column :phone_number
    column :country
    column :age
    column :gender
    column :gender
    default_actions
  end
end
