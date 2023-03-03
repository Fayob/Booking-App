class RemoveUniqueIndex < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email
    add_column :users, :email, :string, default: '', null: false
  end
end
