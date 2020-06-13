class CreateSings < ActiveRecord::Migration[5.2]
  def change
    create_table :sings do |t|
      t.integer :user_id
      t.integer :arthist_id
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
