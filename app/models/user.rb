class User < ApplicationRecord
  require "securerandom"
  self.table_name = "users"
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

   has_one_attached :image

# reset password token

   # def generate_reset_password_token
   #  # debugger

   #  update(reset_password_token: Devise.token_generator.generate(self.class, :reset_password_token))

     
   # end
  # def generate_reset_password_token
  #   update(reset_password_token: Devise.token_generator.generate(User, :reset_password_token),reset_password_sent_at: Time.now)
  # end

 def generate_reset_password_token
    update(reset_password_token: Devise.token_generator.generate(User, :reset_password_token),
           reset_password_sent_at: Time.now,
           reset_password_used: false)
  end

  def reset_password_period_valid?
    reset_password_sent_at && reset_password_sent_at > 2.minutes.ago && !reset_password_used
  end

  def mark_reset_password_as_used
    update(reset_password_used: true)
  end

end
