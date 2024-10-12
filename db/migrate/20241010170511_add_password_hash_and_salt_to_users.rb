class AddPasswordHashAndSaltToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
