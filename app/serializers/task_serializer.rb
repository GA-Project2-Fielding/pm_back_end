class TaskSerializer < ActiveModel::Serializer
  has_many :comments
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :subtasks

  attributes :due_date, :completed, :priority, :title, :description, :created_at

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end
