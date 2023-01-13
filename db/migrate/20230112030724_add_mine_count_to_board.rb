class AddMineCountToBoard < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :mine_count, :integer
  end
end
