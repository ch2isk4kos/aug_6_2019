class Ranking < ApplicationRecord
    has_many :selections
    has_many :players, through: :selections

    accepts_nested_attributes_for :selections, :players

    # selections writer for ranking nested form
    # def selections_attributes=(selection_params)
    #
    # end

    # player writer for ranking nested form


end
