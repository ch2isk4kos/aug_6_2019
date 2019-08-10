class PlayersController < ApplicationController

    before_action :find_player, only: [:show]

    def index
        @players = Player.all
    end

    def new
        @player = Player.new
    end

    def create
        @player = Player.new(player_params)
    end

    def show
    end

    private

    def player_params
        params.require(:player).permit(:name, :position, :number)
    end

    def find_player
        @player = Player.find(params[:id])
    end
    
end
