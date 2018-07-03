class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.references :venueadmin, foreign_key: true

      t.timestamps
    end
  end
end
