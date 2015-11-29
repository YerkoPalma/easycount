# This will guess the User class
FactoryGirl.define do
  factory :company do
    rut "723456789"
    name "Acme"
    description "Una empresa Acme"
    giro "Exportacion"
    comuna "Santiago"
    region "Metropolitana"
    direccion "Del rey 1211"
    rut_representante "175433406"
    selected true
  end

  factory :other_company, class: Company do
    rut "796020903"
    name "Acme2"
    description "Otra empresa Acme"
    giro "Informatica"
    comuna "La Florida"
    region "Metropolitana"
    direccion "Calle falsa 123"
    rut_representante "175433406"
    selected false
  end
end
