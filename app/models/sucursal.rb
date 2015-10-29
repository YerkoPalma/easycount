class Sucursal
  include Mongoid::Document
  field :name, type: String
  field :code, type: Integer
  field :address, type: String
  field :_id, type: String, default: ->{ code }
  belongs_to :company
end
