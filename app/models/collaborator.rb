class Collaborator < ActiveRecord::Base
  after_initialize :defaults

  belongs_to :user
  belongs_to :project

  def defaults
    self.owner = false if self.owner.nil?
  end
end
