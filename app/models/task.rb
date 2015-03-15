class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :file_locations # not sure how dependent: :destroy would work with AWS S3?

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

  def new_subtask(task_params)
    due_date = task_params['due_date']
    completed = task_params['completed']
    title = task_params['title']
    description = task_params['description']

    date_time = DateTime.strptime(due_date, '%Y-%m-%d %T')

    id = self.project_id
    self.subtasks.new(due_date: date_time, title: title, completed: completed, description:description, project_id: id)
  end
end
