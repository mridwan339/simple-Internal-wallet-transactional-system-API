require "test_helper"

class WalletTest < ActiveSupport::TestCase
  setup do
    @user_wallet = Wallet.create!(entity_type: 'User', entity_id: 1, balance: 100.0)
    @team_wallet = Wallet.create!(entity_type: 'Team', entity_id: 1, balance: 200.0)
  end

  test "crediting wallet increases balance" do
    @user_wallet.credit(50.0)
    assert_equal 150.0, @user_wallet.balance
  end

  test "debiting wallet decreases balance" do
    @team_wallet.debit(100.0)
    assert_equal 100.0, @team_wallet.balance
  end

  test "debiting more than balance raises error" do
    assert_raises(RuntimeError, "Insufficient balance") do
      @user_wallet.debit(200.0)
    end
  end

  test "transferring money between wallets" do
    @user_wallet.transfer_to(@team_wallet, 50.0)
    assert_equal 50.0, @user_wallet.balance
    assert_equal 250.0, @team_wallet.balance
  end
end
