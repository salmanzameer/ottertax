class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :ssn_code
  has_many :documents
  after_create :add_user_role

  def add_user_role
  	self.add_role :user
  end
end
