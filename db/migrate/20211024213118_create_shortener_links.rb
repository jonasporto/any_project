class CreateShortenerLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :shortener_links do |t|
      t.text :long_url, null: false, index: true
      t.text :token, null: false, index: true

      t.timestamps
    end
  end
end
