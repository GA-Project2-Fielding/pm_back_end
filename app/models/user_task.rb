class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
end
