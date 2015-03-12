class AddSupercommentToComment < ActiveRecord::Migration
  def change
    add_column :comments, :references, :supercomment
  end
end
