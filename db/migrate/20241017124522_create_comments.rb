# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :audio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
