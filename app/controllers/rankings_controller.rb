class RankingsController < ApplicationController

    before_action :find_ranking, only: [:show]

    def index
        @rankings = Ranking.all.order("created_at DESC")
    end

    def new
        @ranking = Ranking.new

        # user
        @ranking.user_id = current_user.id

        # category


        # selections
        5.times do
            # .build == builds a has_many relationship
            selection_builder = @ranking.selections.build
            # .build_object == builds a belongs_to relationship
            selection_builder.build_player
        end
    end

    def create
        @ranking = Ranking.new(ranking_params)
        # @ranking = current_user.rankings.build(ranking_params)

        # @ranking.user_id = current_user.id
        # @ranking.user = @ranking.current_user.id
        # @ranking.comments.user = User.find_by_id(id: params[:id])
        # @ranking.comments.user = User.find_by_id(params[:id])
        # @ranking.comments.user = @current_user.find_by_id(session[:user_id])

        # binding.pry

        if @ranking.save
            redirect_to ranking_path(@ranking)
        else
            render :new
        end

    end

    def show; end

    private

    def ranking_params
        params.require(:ranking).permit(:description, player_ids: [], selections_attributes: [:player_id, player_attributes: [:name]])
    end

    def find_ranking
        @ranking = Ranking.find(params[:id])
    end

end
