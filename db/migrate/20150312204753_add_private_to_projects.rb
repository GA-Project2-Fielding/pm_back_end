class AddPrivateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :visible, :boolean, null: false, default: false
  end
end
