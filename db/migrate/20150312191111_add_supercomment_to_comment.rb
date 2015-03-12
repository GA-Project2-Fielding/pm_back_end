class AddSupercommentToComment < ActiveRecord::Migration
  def change
    add_column :comments, :belongs_to, :supercomment
  end
end
