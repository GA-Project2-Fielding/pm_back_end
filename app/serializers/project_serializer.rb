class ProjectSerializer < ActiveModel::ProjectSerializer
  has_many :collaborators
  has_many :users, through: :collaborators
  has_many :tasks

  attributes :id, :project_title, :description, :start_date, :due_date, :completion_date, :completed, :visible
end
