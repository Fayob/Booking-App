class ChangesToTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :coaches, :city
    add_column :reserves, :city, :string
    add_column :reserves, :date, :date
  end
end
