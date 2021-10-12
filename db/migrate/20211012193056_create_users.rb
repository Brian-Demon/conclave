class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :provider
      t.integer :uid

      t.timestamps
    end
  end
end
