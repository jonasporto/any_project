class CreateShortenerLinkVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :shortener_link_visitors do |t|
      t.string :referrer
      t.string :ip_address
      t.string :session_id
      t.references :shortener_link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
