class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :supercomment_id

  belongs_to :user
  belongs_to :task

  has_many :subcomments
  belongs_to :supercomment

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end
