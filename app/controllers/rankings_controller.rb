class RankingsController < ApplicationController

    before_action :find_ranking, only: [:show]

    def index
        @rankings = Ranking.all
    end

    def new
        @ranking = Ranking.new
    end

    def create
        @ranking = Ranking.new(ranking_params)
    end

    def show; end

    private

    def ranking_params
        params.require(:ranking).permit(:description, selections_attributes: [:ranking_position])
    end

    #, player_ids: [], players_attributes: [:name, :position, :number]

    def find_ranking
        @ranking = Ranking.find(params[:id])
    end
    
end
