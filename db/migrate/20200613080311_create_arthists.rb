class CreateArthists < ActiveRecord::Migration[5.2]
  def change
    create_table :arthists do |t|
      t.string :name
      t.string :instagram_link
      t.boolean :debut, default: false
      t.date :debut_date

      t.timestamps
    end
  end
end
