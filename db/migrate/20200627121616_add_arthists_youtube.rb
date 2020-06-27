class AddArthistsYoutube < ActiveRecord::Migration[5.2]
  def change
    add_column :arthists, :youtube_link, :string
  end
end
