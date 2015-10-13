class RutValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value = value.to_s
    value = value[0,value.length - 1]
    rutValue = value.to_i
    if rutValue < 72000000
      record.errors.add attribute, (options[:message] || "Rut debe ser mayor a 72.000.000")
    end
  end
end

class DVValidator < ActiveModel::Validator
  require 'rut_chileno'
  def validate(record)
    unless RUT::validar(record.rut)
      record.errors[:rut] << I18n.t(:invalid_rut)
    end
  end
end

class Company
  include Mongoid::Document
  include Mongoid::Paperclip
  include ActiveModel::Validations

  field :rut, type: String
  field :name, type: String
  field :giro, type: String
  field :direccion, type: String
  field :comuna, type: String
  field :region, type: String
  field :avatar, type: String
  field :description, type: String
  field :selected, type: Boolean
  field :_id, type: String, default: ->{ rut }

  validates_with DVValidator

  has_mongoid_attached_file :avatar, default_url: ActionController::Base.helpers.asset_path('default.jpg')
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  embedded_in :contador, class_name: "User", inverse_of: :companies

  validates :contador, presence: true
  validates :name, presence: true
  validates :rut, rut: true
  validates :giro, presence: true
  validates :direccion, presence: true
  validates :comuna, presence: true
  validates :region, presence: true
end
