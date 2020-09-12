class Cell < ApplicationRecord
  belongs_to :game
  enum state: [:covered, :revealed, :flagged]

  def set_mine
  	update_column(:mined, true)
    neighbors.update_all('mines_around = mines_around + 1')
  end

  def neighbors
    valid_neighbors = posible_neighbours.map do |neighbour|
      if valid_position(neighbour)
        "(x_axis = #{neighbour[0]} AND y_axis = #{neighbour[1]})"
      end
    end
    Cell.where(valid_neighbors.compact.join(' OR ')).where(:game_id => game_id, :mined => false)
  end

  def mark
    start_timer
    if state == "covered"
      update_column(:state, "flagged")
    elsif state == "flagged"
      update_column(:state, "covered")
    end
  end

  def reveal
    start_timer
    if cell_available?
   		update_column(:state, "revealed")
   		if mined?
   			game.lost!
   		elsif game.all_cells_revealed?
   			game.won!
   		else
          #reveal_neighbours
   		end
    end
  end

  def mines_around?
    mines_around > 0
  end

  private

  def reveal_neighbours
  end

  def posible_neighbours
    [ #top
      [x_axis - 1, y_axis - 1],
      [x_axis - 1, y_axis],
      [x_axis - 1, y_axis + 1],
      #center
      [x_axis, y_axis - 1],
      [x_axis, y_axis + 1],
      #bottom
      [x_axis + 1, y_axis - 1],
      [x_axis + 1, y_axis],
      [x_axis + 1, y_axis + 1]
    ]
  end

  def start_timer
    game.begin! if !game.started_at
  end

  def cell_available
    game.in_progress? && state == "covered" || state == "flagged"
  end

  def valid_position(vector)
    vector[0].between?(0, game.columns - 1) && vector[1].between?(0, game.rows - 1)
  end
end
