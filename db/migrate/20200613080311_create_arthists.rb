class CreateArthists < ActiveRecord::Migration[5.2]
  def change
    create_table :arthists do |t|
      t.integer :user_id
      t.string :name
      t.string :link
      t.boolean :debut, default: false
      t.date :debut_date

      t.timestamps
    end
  end
end
