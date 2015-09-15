class Company
  include Mongoid::Document
  field :rut, type: Integer
  field :name, type: String
  field :description, type: String
  
  embedded_in :contador, class_name: "User", inverse_of: :companies
end
