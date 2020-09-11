class GamesController < ApplicationController
  before_action :find_user

  def index
    @games = @user.games
    render :index, :status => :ok, :formats => :json
  end

  def show
    render :show, :status => :ok, :formats => :json
  end

  def create
    @game = @user.games.create!(game_params)
    render :create, :status => :created, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end


  private
  	def find_user
  		@user = User.find(params[:user_id])
  	end

    def game_params
      params.require(:game).permit(:columns, :rows, :mines)
    end
end
