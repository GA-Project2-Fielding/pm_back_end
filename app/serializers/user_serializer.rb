class UserSerializer < ActiveModel::Serializer
  has_many :collaborators
  has_many :projects, through: :collaborators
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :comments

  attributes :user_name, :email, :first_name, :last_name, :image_url, :description
end
