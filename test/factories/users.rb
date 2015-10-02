# This will guess the User class
FactoryGirl.define do
  factory :user do
    email "test@example.com"
    name "TestUser"
    password "password"
    password_confirmation "password"
  end
  
  factory :other, class: User do
    email "foo@bar.com"
    name "FooBarUsr"
    password "foobar"
    password_confirmation "foobar"
  end
end