class AddSupertaskToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :references, :supertask
  end
end
