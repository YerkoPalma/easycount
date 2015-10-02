class RutValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "Rut debe ser mayor a 72.000.000") unless
      value = value.to_s
      value = value[0,value.length - 1]
      value.to_i > 72000000
  end
end

class Company
  include Mongoid::Document
  include Mongoid::Paperclip
  include ActiveModel::Validations

  field :rut, type: Integer
  field :name, type: String
  field :avatar, type: String
  field :description, type: String
  field :selected, type: Boolean

  has_mongoid_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  embedded_in :contador, class_name: "User", inverse_of: :companies
  
  validates :contador, presence: true
  validates :name, presence: true
  validates :rut, rut: true
end
