class CreateFileLocations < ActiveRecord::Migration
  def change
    create_table :file_locations do |t|
      t.string :name
      t.string :url, null: false
      t.belongs_to :task, index: true

      t.timestamps
    end
    add_foreign_key :file_locations, :tasks
  end
end
