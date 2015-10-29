class Cargo
  include Mongoid::Document
  field :name, type: String
  field :code, type: Integer
  field :_id, type: String, default: ->{ code }
  belongs_to :company
end