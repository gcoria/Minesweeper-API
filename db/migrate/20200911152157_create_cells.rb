class CreateCells < ActiveRecord::Migration[6.0]
  def change
    create_table :cells do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :x_axis
      t.integer :y_axis
      t.integer :mines_around, :default => 0
      t.integer :state, :default => 0

      t.timestamps
    end
  end
end
