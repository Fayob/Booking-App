class AddUserRefToCoach < ActiveRecord::Migration[7.0]
  def change
    add_reference :coaches, :user, null: false, foreign_key: true
  end
end
