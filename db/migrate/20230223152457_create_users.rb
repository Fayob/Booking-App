class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :name
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
