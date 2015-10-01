# This will guess the User class
FactoryGirl.define do
  factory :user do
    email "test@example.com"
    name "TestUser"
    password "password"
    password_confirmation "password"
  end
  
end