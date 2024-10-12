class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.references :owner, foreign_key: { to_table: :users }, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0

      t.timestamps
    end
  end
end
