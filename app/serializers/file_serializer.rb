class FileSerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  belongs_to :task
end
