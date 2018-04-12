class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.references :user, foreign_key: true
      t.string :image
      t.string :title
      t.string :description
      t.string :tag
      t.string :cmmaker
      t.string :cmmodelcode
      t.string :lzmaker
      t.string :lzmount
      t.string :lzmodelcode

      t.timestamps
    end
  end
end
