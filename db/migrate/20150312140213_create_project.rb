class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_title, null: false
      t.text :description
      t.datetime :start_date, null: false
      t.datetime :due_date
      t.datetime :completion_date
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
