class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  validates :phone, length: { minimum: 2 }
  validates_uniqueness_of :phone
  index({ phone: 1 } , { unique: true })


  ## Database authenticatable
  field :phone,              type: String, default: ""
  # field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time




  field :name, type: String
  field :starting_weight, type: Integer
  field :target_weight, type: Integer
  field :default_exercise_time, type: Time

  before_validation do |rec|
    rec.phone = rec.phone.parameterize.gsub('-', '')
    if rec.phone.length == 11
      rec.phone = rec.phone = rec.phone[1..-1]
    end
  end
end
