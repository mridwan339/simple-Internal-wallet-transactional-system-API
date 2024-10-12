require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  setup do
    @wallet1 = Wallet.create!(entity_type: 'User', entity_id: 1, balance: 100.0)
    @wallet2 = Wallet.create!(entity_type: 'Team', entity_id: 2, balance: 200.0)
  end

  test "creating credit transaction should not have source wallet" do
    transaction = Transaction.new(target_wallet_id: @wallet1.id, amount: 50.0, transaction_type: 'credit')
    assert transaction.valid?
    assert_nil transaction.source_wallet_id
  end

  test "creating debit transaction should not have target wallet" do
    transaction = Transaction.new(source_wallet_id: @wallet2.id, amount: 50.0, transaction_type: 'debit')
    assert transaction.valid?
    assert_nil transaction.target_wallet_id
  end
end
