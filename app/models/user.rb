class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :token, presence: true

  has_many :collaborators
  has_many :projects, through: :collaborators

  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_many :comments

  has_secure_password

  before_create :generate_token

  def generate_token
    return if token.present?
    begin
      self.token = SecureRandom.uuid.gsub(/\-/, '')
    end while self.class.exists?(token: token)
  end
end
