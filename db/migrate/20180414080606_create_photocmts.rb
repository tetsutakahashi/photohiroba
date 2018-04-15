class CreatePhotocmts < ActiveRecord::Migration[5.0]
  def change
    create_table :photocmts do |t|
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
