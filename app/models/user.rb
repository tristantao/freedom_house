class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :sources

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :admin

  validates_confirmation_of :password
  validates :first_name, :last_name, :email, :presence => true

  def admin_privileges
    if self.admin
      return "Yes"
    end
    return "No"
  end

  def name
    return self.first_name + " " + self.last_name
  end

end
