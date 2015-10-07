class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::EmbeddedErrors

  field :email, type: String
  field :name, type: String
  field :remember_token, type: String
  field :password_digest, type: String
  field :_id, type: String, default: ->{ name }

  embeds_many :companies, class_name: "Company", inverse_of: :contador, cascade_callbacks: true

  before_save { self.email = email.downcase }

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }, on: :create
  #validates :password, presence: true, on: :create

  validates :password, length: { minimum: 6 }, on: :update_password
  #validates :password, presence: true, on: :update_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def User.getPass(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
