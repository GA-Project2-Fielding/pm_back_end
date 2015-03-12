class Project < ActiveRecord::Base
  after_initialize :defaults

  validates :project_title, presence: true
  validates :start_date, presence: true

  has_many :collaborators
  has_many :users, through: :collaborators

  has_many :tasks, dependent: :destroy

  def defaults
   self.completed = false if self.completed.nil?
   self.visible = true if self.visible.nil?
  end
end
