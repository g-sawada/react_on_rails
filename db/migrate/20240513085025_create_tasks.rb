class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
