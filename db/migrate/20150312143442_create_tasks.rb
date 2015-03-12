class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :due_date
      t.boolean :completed, null: false, default: false
      t.integer :priority, null: false, default: 0
      t.string :title, null: false
      t.text :description
      t.belongs_to :project, index: true
      t.references :supertask, index: true

      t.timestamps
    end
    add_foreign_key :tasks, :projects
  end
end
