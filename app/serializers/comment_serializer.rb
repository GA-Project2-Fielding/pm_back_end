class CommentSerializer < ActiveModel::Serializer
  attributes :body, :created_at

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end