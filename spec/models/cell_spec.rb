require 'rails_helper'

RSpec.describe Cell, type: :model do
  context "validations" do
    it "game can't be blank" do
      expect {
        create(:cell, :game_id => nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Game must exist/)
    end

    it "default cell state is " do
      expect(create(:cell).state).to match("covered")
    end
  end
end
