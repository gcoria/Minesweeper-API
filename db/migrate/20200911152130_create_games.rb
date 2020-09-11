class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :columns
      t.integer :rows
      t.integer :mines
      t.integer :state, :default => 0

      t.timestamps
    end
  end
end
