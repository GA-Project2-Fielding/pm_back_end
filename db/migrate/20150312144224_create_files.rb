class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string :name
      t.string :url, null: false
      t.belongs_to :task, :index: true

      t.timestamps
    end
    add_foreign_key :files, :tasks
  end
end
