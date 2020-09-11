class Game < ApplicationRecord
  belongs_to :user
  has_many :cells
  enum state: [:is_new, :in_progress, :won, :lost]

  validates :rows, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :columns, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :mines, :presence => true, :numericality => {:only_integer => true, :greater_than => 0 }

  def over
  	self.state == "won" || self.state == "lost"
  end
end
