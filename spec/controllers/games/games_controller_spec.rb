require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  render_views

  before(:all) do
    DatabaseCleaner.clean 
    @user = create(:user)
  end

  describe "Create game" do
    let(:game_params) { attributes_for(:game) }
    before { post :create, {:params => {:user_id => @user.id.to_s, :game => game_params} } } 
    it { expect(response).to have_http_status(:created) }
  end
  
  describe "List user games" do
      before { get :index, {:params => {:user_id => @user.id.to_s} }}
      it { expect(response).to have_http_status(:ok)  }
  end

  describe "Show users games" do
    let!(:games) do
      create_list(:game, 3, :user => @user)
    end
    before { get :show, {:params => {:user_id => @user.id.to_s, :id => games.first.id.to_s} }}
    context "HTTP 200" do
      it { expect(response).to have_http_status(:ok)  }
    end
    context "HTTP 404" do
      before { get :show, {:params => {:user_id => @user.id.to_s, :id => 123456712} }}
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe "Mark cell" do
    let!(:game) do
      create(:game, :user => @user, :mines => 1)
    end

    describe "mark cell [1,1]" do
      before do
        game.cells.update_all(:mined => false, :mines_around => 0)
        game.find_cell(0,0).set_mine
        game.cells.reload
        put :mark, {:params => {:user_id => @user.id, :id => game.id, :x_axis => 1, :y_axis => 1} }
      end
      context "HTTP 200" do
        it { expect(response).to have_http_status(:ok)  }
      end
    end

    describe "reveal cell [1,1]" do
      before do
        game.cells.update_all(:mined => false, :mines_around => 0)
        game.find_cell(0,0).set_mine
        game.cells.reload
        put :reveal, {:params => {:user_id => @user.id, :id => game.id, :x_axis => 1, :y_axis => 1} }
      end
      context "HTTP 200" do
        it { expect(response).to have_http_status(:ok)  }
      end
    end
  end
end