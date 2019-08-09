class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :rankings do |t|
      t.text :description

      t.timestamps
    end
  end
end
