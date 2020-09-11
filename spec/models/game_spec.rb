require 'rails_helper'

RSpec.describe Game, type: :model do
  context "validations" do
    it "user can't be blank" do
      expect {
        create(:game, :user_id => nil)
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
        create(:game, :columns => nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Columns can't be blank/)
    end
  
    it "Columns must be greater than" do
      expect {
        create(:game, :columns => 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Columns must be greater than/)
    end

    it "Rows can't be blank" do
      expect {
        create(:game, :rows => nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Rows can't be blank/)
    end
  
    it "Rows must be greater than" do
      expect {
        create(:game, :rows => 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Rows must be greater than/)
    end

    it "Mines can't be blank" do
      expect {
        create(:game, :mines => nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Mines can't be blank/)
    end
  
    it "Mines must be greater than" do
      expect {
        create(:game, :mines => 0)
      }.to raise_error(ActiveRecord::RecordInvalid, /Mines must be greater than/)
    end
  end
end
