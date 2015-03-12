class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :task_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :task

  has_many :subcomments, class_name: "Comment", foreign_key: "supercomment_id"
  belongs_to :supercomment, class_name: "Comment"
end
