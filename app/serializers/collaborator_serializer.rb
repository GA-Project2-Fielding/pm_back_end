class CollaboratorSerializer < ActiveModel::Serializer
  attributes :id, :role, :owner, :user_id, :project_id

  belongs_to :user
  belongs_to :project
end
