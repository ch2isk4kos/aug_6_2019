class Ranking < ApplicationRecord
    has_many :selections
    has_many :players, through: :selections

    accepts_nested_attributes_for :selections
    accepts_nested_attributes_for :players

    # accepts_nested_attributes_for :category, reject_if: proc { |attributes| attributes['name'].blank? }
    # accepts_nested_attributes_for :players, reject_if: proc { |attributes| attributes['name'].blank? }
    # accepts_nested_attributes_for :selections, reject_if: proc {|selection_params| selection_params.values.any?(&:empty?) || (selection_params["player_attributes"]["name"].blank? && !selection_params["player_id"])}

    def players_attributes=(player_params)
        players_params.values.each do |player_attribute|
            self.players << Player.find_or_create_by(player_attribute) if !player_attribute['name'].empty?
        end
    end

    def selections_attributes=(selection_params)
        selection_params.values.each do |selection_attribute|
            #if !selection_attribute.values.any?(&:empty?) && (!selection_attribute[:player_attributes][:name].blank? || selection_attribute[:player_id])
                self.selections << Selection.create(selection_attribute)
            #end
        end
    end

    # !selection_params.values.any?(&:empty?)
    # !selection_params.values.any?{|x|x.empty?}

end
