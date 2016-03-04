class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :img
      t.text :about
      t.string :auth_token

      t.timestamps null: false
    end
  end
end
