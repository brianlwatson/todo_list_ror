class Task < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.float :effort
      t.integer :priority
    end
  end
end
