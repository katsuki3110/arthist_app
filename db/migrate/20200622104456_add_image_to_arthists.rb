class AddImageToArthists < ActiveRecord::Migration[5.2]
  def change
    add_column :arthists, :image, :string
  end
end
