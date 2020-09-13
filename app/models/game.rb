class Game < ApplicationRecord
  require 'matrix'

  belongs_to :user
  has_many :cells
  enum state: [:is_new, :in_progress, :won, :lost]

  after_create :set_board

  validates :rows, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :columns, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :mines, :presence => true, :numericality => {:only_integer => true, :greater_than => 0 }

  def find_cell(x,y)
    cells.find_by(:x_axis => x, :y_axis => y)
  end

  def all_cells_revealed?
    cells.where(state: Cell.states[:revealed]).count == cells.size - mines
  end

  def duration
    ended? ? (ended_at - started_at) / 60 : "still_playing"
  end

  def begin!
    update_column(:started_at, Time.zone.now)
    update_column(:state, "in_progress")
  end

  def lost!
    update_column(:state, "lost")
    set_end_game
  end

  def won!
    update_column(:state, "won")
    set_end_game
  end

  private

  def ended?
    state == "lost" || state == "won"
  end

  def set_end_game
    update_column(:ended_at, Time.zone.now)
    cells.update_all(state: Cell.states[:revealed])
  end

  def set_board
    Matrix.build(rows, columns) {|row, col| cells.create(:x_axis => row, :y_axis => col)}
    cells.sample(mines).map{|c| c.set_mine}
  end
end
