class Board < ApplicationRecord
  validates :width, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :mine_count, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: :area}

  def area 
    return self.width * self.height
  end
end
