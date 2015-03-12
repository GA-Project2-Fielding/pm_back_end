class UserSerializer < ActiveModel::Serializer
  attributes :user_name, :email, :first_name, :last_name, :image_url, :description
end
