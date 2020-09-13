require 'rails_helper'

RSpec.describe Game, type: :model do
  context "validations" do
    it "user can't be blank" do
      expect {
        create(:game, user_id: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /User must exist/)
    end

    it "default game state when created is new" do
      expect(create(:game).state).to match("is_new")
    end

    it "game over" do
      game = create(:game)
      game.won!
      expect(game.state).to match("won")
    end

    it "game over" do
      game = create(:game)
      game.lost!
      expect(game.state).to match("lost")
    end
  
  
    it "Columns can't be blank" do
      expect {
        create(:game, columns: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Columns can't be blank/)
    end
  
    it "Columns must be greater than" do
      expect {
        create(:game, columns: 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Columns must be greater than/)
    end

    it "Rows can't be blank" do
      expect {
        create(:game, rows: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Rows can't be blank/)
    end
  
    it "Rows must be greater than" do
      expect {
        create(:game, rows: 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Rows must be greater than/)
    end

    it "Mines can't be blank" do
      expect {
        create(:game, mines: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Mines can't be blank/)
    end
  
    it "Mines must be greater than" do
      expect {
        create(:game, mines: 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Mines must be greater than/)
    end
  end
  context 'Build  game' do
    let(:game) { create(:game) }
    it { expect(game.cells).to all(be_a(Cell)) }
    it { expect(game.cells.size).to eq(9) }

    it "mines match with user prefs" do
      total_mines = game.cells.select(&:mined).size
      expect(game.mines).to eq(total_mines)
    end
  end
     
  context 'Finding neighbors(3X3)' do
    let(:game) { create(:game, columns: 3, rows: 3, mines: 1) }
    let(:cell) { game.find_cell(1,1) }
    let(:marked_cell) { game.find_cell(1,0) }
    let(:mines_near) { cell.neighbors }
    let(:cell_with_mine) { game.find_cell(0,0) }
    
    before do
      game.cells.update_all(mined: false)
      game.find_cell(0,0).set_mine
    end

    it { expect(mines_near).not_to be_empty }
    it { expect(mines_near).to all(be_a(Cell)) }
  
    it "all valid neighbors except (0,0) that has a mine" do
      expect(mines_near.size).to eq(7)
    end

    it "marked cell is flagged" do
      marked_cell.mark
      expect(marked_cell.state).to match("flagged")
    end

    it "lose game when reveal (0,0)" do
      cell_with_mine.reveal
      expect(game.state).to match("lost")
    end
  end

  context 'Win game (2X2)' do
    let(:game) { create(:game, columns: 2, rows: 2, mines: 1) }
    let(:cell_1) { game.find_cell(1,1) }
    let(:cell_2) { game.find_cell(1,0) }
    let(:cell_3) { game.find_cell(0,1) }
    
    before do
      game.cells.update_all(mined: false)
      game.find_cell(0,0).set_mine
    end

    it "lose game when reveal (0,0)" do
      cell_1.reveal
      cell_2.reveal
      cell_3.reveal
      expect(game.state).to match("won")
    end
  end
end
