class Task <ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy
  has_many :user_tasks
  has_many :users, through: :user_tasks

  has_many :subtasks, class_name: "Task", foreign_key: "supertask_id"
  belongs_to :supertask, class_name: "Task"


  after_initialize :defaults

  validates_presence_of :project
  validates_associated :project
  validates :due_date, presence: true
  validates_numericality_of :priority, only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_blank: true
  validates :title, presence: true

  def defaults
    self.priority ||= 0
    self.completed = false if self.completed.nil?
  end

  def create_subtask(title, due_date, completed: false, priority: 0, description: nil)
    id = self.project_id
    self.subtasks.create(title: title, due_date: due_date, project_id: id, completed: completed, priority: priority, description: description)
  end
end
