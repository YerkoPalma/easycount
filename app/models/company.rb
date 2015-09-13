class Company
  include Mongoid::Document
  field :rut, type: Integer
  field :name, type: String
  
  belongs_to :contador, class_name: "User", inverse_of: :companies
end
