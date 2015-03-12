class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string :name
      t.string :url, null: false

      t.timestamps
    end
  end
end
