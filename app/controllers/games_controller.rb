class GamesController < ApplicationController
  before_action :find_user
  before_action :find_game, only: [:show]
  before_action :find_cell, only: [:mark, :reveal]

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

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

  def mark
    @cell.mark
    render :show, :status => :ok, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  def reveal
    @cell.reveal
    render :show, :status => :ok, :formats => :json
  rescue => e
    render :json => { :error => e.message }, :status => :unprocessable_entity
  end

  private
    def find_game
      @game = @user.games.find(params[:id])
    end

    def find_cell
      find_game
      @cell = @game.find_cell(location_params[:x_axis], location_params[:y_axis])
    end

  	def find_user
  		@user = User.find(params[:user_id])
  	end

    def game_params
      params.require(:game).permit(:columns, :rows, :mines)
    end

    def location_params
      params.permit(:x_axis, :y_axis)
    end
end
