class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :email, :first_name, :last_name, :image_url, :description

  has_many :collaborators
  has_many :projects, through: :collaborators
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :comments
end
