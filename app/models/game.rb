class Game < ApplicationRecord
  require 'matrix'

  belongs_to :user
  has_many :cells
  enum state: [:is_new, :in_progress, :won, :lost]

  after_create :set_board

  validates :rows, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :columns, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :mines, :presence => true, :numericality => {:only_integer => true, :greater_than => 0 }

  def all_cells_revealed
    cells.where(state: Model.statuses[:revealed]).count == cells.size - mines
  end

  def lost!
    update_column(:state, "lost")
    cells.update_all(state: Cell.states[:revealed])
  end

  def won!
    update_column(:state, "won")
    cells.update_all(state: Cell.states[:revealed])
  end

  def set_board
    Matrix.build(rows, columns) {|row, col| cells.create(:x_axis => row, :y_axis => col)}
    cells.sample(mines).map{|c| c.set_mine}
  end

  def coords(row,column)
    cells.find_by(:x_axis => row, :y_axis => column)
  end
end
