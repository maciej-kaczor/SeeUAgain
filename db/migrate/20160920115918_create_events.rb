class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :place
      t.datetime :date
      t.integer :owner_id
      t.integer :max_participants

      t.timestamps
    end
  end
end
