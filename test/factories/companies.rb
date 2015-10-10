# This will guess the User class
FactoryGirl.define do
  factory :company do
    rut "723456789"
    name "Acme"
    description "Una empresa Acme"
    selected true
  end

  factory :other_company, class: Company do
    rut "796020903"
    name "Acme2"
    description "Otra empresa Acme"
    selected false
  end
end
