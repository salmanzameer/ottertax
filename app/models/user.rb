class User < ApplicationRecord
  rolify
  audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable, :session_limitable

  belongs_to :ssn_code
  has_many :documents
  after_create :add_user_role

  def add_user_role
  	self.add_role :user
  end

  def full_name
    first_name.to_s+" "+last_name.to_s
  end
end
