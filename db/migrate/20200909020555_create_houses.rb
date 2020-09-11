# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price

      t.timestamps
    end
  end
end
