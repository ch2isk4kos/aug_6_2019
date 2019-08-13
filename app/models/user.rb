class User < ApplicationRecord
    has_secure_password
    has_many :comments
    has_many :rankings, through: :comments

    # accepts_nested_attributes_for :comments
    # accepts_nested_attributes_for :rankings

    # def comments_attributes=(comment_params)
    #     comment_params.values.each do |comment_attribute|
    #         self.comments << Comment.create(comment_attribute) if !comment_attribute['content'].empty?
    #     end
    # end
    #
    # def rankings_attributes=(ranking_params)
    #     ranking_params.values.each do |ranking_attribute|
    #         #if !ranking_attribute.values.any?(&:empty?) && (!ranking_attribute["player_attributes"]["name"].blank? || ranking_attribute["player_id"])
    #             self.rankings << Ranking.find_or_create_by(ranking_attribute)
    #         #end
    #     end
    # end

    # !selection_params.values.any?(&:empty?)
    # !selection_params.values.any?{|x|x.empty?}


end
