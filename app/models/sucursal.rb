class Sucursal
  include Mongoid::Document
  field :name, type: String
  field :code, type: Integer
  belongs_to :company
end
