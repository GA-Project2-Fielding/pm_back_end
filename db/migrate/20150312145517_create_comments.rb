class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true
      t.references :supercomment, index: true

    end
    add_foreign_key :comments, :tasks
    add_foreign_key :comments, :users
  end
end
