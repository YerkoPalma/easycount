# This will guess the User class
FactoryGirl.define do
  factory :company do
    rut 123456789
    name "Acme"
    avatar ""
    description "Una empresa Acme"
    selected false
  end
  
end