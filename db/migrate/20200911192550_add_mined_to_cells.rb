class AddMinedToCells < ActiveRecord::Migration[6.0]
  def change
    add_column :cells, :mined, :boolean, default: false
  end
end
