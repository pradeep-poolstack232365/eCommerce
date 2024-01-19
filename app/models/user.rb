class User < ApplicationRecord
  require "securerandom"
  self.table_name = "users"
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

   has_one_attached :image
end
