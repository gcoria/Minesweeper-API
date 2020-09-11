class Cell < ApplicationRecord
  belongs_to :game
  enum state: [:covered, :revealed, :flagged]

  def set_mine
  	update_column(:mined, true)
  end


  def reveal
    if cell_available?
   		update_column(:state, "revealed")
   		if mined?
   			game.lost!
   		elsif game.all_cells_revealed?
   			game.won!
   		else
   			reveal_neighbours
   		end
    end
  end

  def reveal_neighbours
  end

  def cell_available
  	game.in_progress? && state == "covered"
  end
end
