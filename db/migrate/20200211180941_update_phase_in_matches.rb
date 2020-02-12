class UpdatePhaseInMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :phase, :string
  end
end
