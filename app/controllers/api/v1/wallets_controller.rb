class Api::V1::WalletsController < ApplicationController
  def show
    wallet = Wallet.find(params[:id])
    render json: wallet, include: { owner: { only: [:name, :email] } }
  end

  def create
    wallet = Wallet.new(wallet_params)
    if wallet.save
      render json: wallet, status: :created
    else
      render json: wallet.errors, status: :unprocessable_entity
    end
  end

  def create
    wallet = Wallet.new(wallet_params)
    if wallet.save
      render json: wallet, status: :created
    else
      render json: wallet.errors, status: :unprocessable_entity
    end
  end

  def credit
    wallet = Wallet.find(params[:id])
    amount = params[:amount].to_f
    wallet.credit(amount)
    render json: { message: 'Wallet credited successfully', new_balance: wallet.balance }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def debit
    wallet = Wallet.find(params[:id])
    amount = params[:amount].to_f
    wallet.debit(amount)
    render json: { message: 'Wallet debited successfully', new_balance: wallet.balance }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def transfer
    source_wallet = Wallet.find(params[:id])
    target_wallet = Wallet.find(params[:target_wallet_id])
    amount = params[:amount].to_f
    source_wallet.transfer_to(target_wallet, amount)
    target_wallet.transfering_to(amount)
    render json: { message: 'Transfer completed successfully', source_wallet_balance: source_wallet.balance, target_wallet_balance: target_wallet.balance }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def transactions
    wallet = Wallet.find(params[:id])
    transactions = Transaction.where(source_wallet: wallet, transaction_type: ['debit', 'credit']).or(Transaction.where(target_wallet: wallet))
    render json: transactions.map { |transaction|
      {
        id: transaction.id,
        amount: transaction.amount,
        transaction_type: transaction.transaction_type,
        source_wallet_id: transaction.source_wallet_id,
        source_wallet_owner: transaction.source_wallet&.owner&.slice(:name, :email),
        target_wallet_id: transaction.target_wallet_id,
        target_wallet_owner: transaction.target_wallet&.owner&.slice(:name, :email),
        created_at: transaction.created_at
      }
    }
  end

  private

  def wallet_params
    params.require(:wallet).permit(:owner_id, :balance)
  end
end
