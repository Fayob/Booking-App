class CreateReserves < ActiveRecord::Migration[7.0]
  def change
    create_table :reserves do |t|
      t.boolean :reserved, default: false
      
      t.timestamps
    end
    add_reference :reserves, :user, null: false, foreign_key: true
    add_reference :reserves, :coach, null: false, foreign_key: true
  end
end
