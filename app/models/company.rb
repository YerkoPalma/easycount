class Company
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :rut, type: Integer
  field :name, type: String
  field :avatar, type: String
  field :description, type: String
  
  has_mongoid_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  
  embedded_in :contador, class_name: "User", inverse_of: :companies
end
