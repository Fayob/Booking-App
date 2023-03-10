class AddColumnToCoach < ActiveRecord::Migration[7.0]
  def change
    add_column :coaches, :city, :string
  end
end
