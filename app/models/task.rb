class Task <ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy
  has_many :user_tasks
  has_many :users, through: :user_tasks
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
end
