class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true
    end
    add_foreign_key :user_tasks, :users
    add_foreign_key :user_tasks, :tasks
  end
end
