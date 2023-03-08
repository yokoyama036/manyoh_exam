class User < ApplicationRecord
  before_destroy :admin_cannot_delete
  before_update :admin_cannot_update
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true ,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def admin_cannot_update
    throw :abort if User.exists?(admin: true) && self.saved_change_to_admin == [true, false]
  end

  def admin_cannot_delete
      throw :abort if User.exists?(admin: true) && self.admin == true
  end
end