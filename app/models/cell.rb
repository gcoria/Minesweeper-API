class Cell < ApplicationRecord
  belongs_to :game
  enum state: [:covered, :revealed, :mined, :flagged]

  def set_mine
  	self.mined!
  end
end
