class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :original
      t.string :shortened
      t.references :user, index: true

      t.timestamps
    end
  end
end
