class Sucursal
  include Mongoid::Document
  field :name, type: String
  field :code, type: Integer
  field :address, type: String
  belongs_to :company
end
