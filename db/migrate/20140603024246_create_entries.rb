class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.datetime :start
      t.datetime :end
      t.text :description

      t.timestamps
    end
  end
end
