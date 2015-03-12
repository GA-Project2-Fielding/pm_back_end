class AddSupertaskToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :belongs_to, :supertask
  end
end
