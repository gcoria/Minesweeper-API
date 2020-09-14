require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before(:all) do
    DatabaseCleaner.clean 
    @user = create(:user)
  end

  describe "Create User" do
    let(:user_params) { attributes_for(:user) }
    before { post :create, {:params => {user: user_params} } } 
    it { expect(response).to have_http_status(:created) }
  end
  
  describe "List users" do
      before { get :index }
      it { expect(response).to have_http_status(:ok)  }
    end

  describe "Show user" do
    before { get :show, {:params => {:id => @user.id.to_s} } }
    context "HTTP 200" do
      it { expect(response).to have_http_status(:ok)  }
    end
    context "HTTP 404" do
      before { get :show, {:params => {:id => 123456} }}
      it { expect(response).to have_http_status(:not_found) }
    end
  end
end