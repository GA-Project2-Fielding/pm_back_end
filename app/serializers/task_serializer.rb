class TaskSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :completed, :priority, :title, :description, :created_at, :supertask_id

  has_many :comments
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :subtasks
  belongs_to :project

  has_many :subtasks
  belongs_to :supertask

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end
