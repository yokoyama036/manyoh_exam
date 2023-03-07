class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true ,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
