class CreateSlowJobs < ActiveRecord::Migration
  def change
    create_table :slow_jobs do |t|
      t.string :name
      t.integer :requested_time
      t.integer :returned_at
      t.text :description

      t.timestamps null: false
    end
  end
end
