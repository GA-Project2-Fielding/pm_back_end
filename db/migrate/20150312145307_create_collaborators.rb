class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :role
      t.boolean :owner, null: false, default: false
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
    end
    add_foreign_key :collaborators, :users
    add_foreign_key :collaborators, :projects
  end
end
