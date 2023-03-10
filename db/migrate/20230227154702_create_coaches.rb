class CreateCoaches < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :image, default: 'https://png.pngtree.com/png-clipart/20220621/original/pngtree-default-photo-placeholder-account-anonymous-png-image_8176883.png'
      t.string :description

      t.timestamps
    end
  end
end
