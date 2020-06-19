class CreateSings < ActiveRecord::Migration[5.2]
  def change
    create_table :sings do |t|
      t.integer :user_id
      t.integer :arthist_id
      t.string :link
      t.integer :video_flg

      t.timestamps
    end
  end
end
