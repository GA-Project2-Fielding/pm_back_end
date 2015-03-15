class FileLocation < ActiveRecord::Base
  belongs_to :task

  validates_presence_of :task
  validates_associated :task
  validates :url, presence: :true
end
