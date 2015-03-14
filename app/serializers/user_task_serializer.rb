class UserTaskSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :task_id

  belongs_to :user
  belongs_to :task
end
