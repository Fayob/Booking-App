class ChangeTable < ActiveRecord::Migration[7.0]
  def change
    change_column :reserves, :date, :datetime
  end
end
