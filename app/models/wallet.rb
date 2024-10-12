class Wallet < ApplicationRecord
    belongs_to :owner, class_name: 'User', optional: false
    has_many :transactions, dependent: :destroy

    #validates :balance, numericality: { greater_than_or_equal_to: 0 }

    def credit(amount)
        ActiveRecord::Base.transaction do
            self.balance += amount
            save!
            Transaction.create!(source_wallet: nil, target_wallet: self, amount: amount, transaction_type: 'credit')
        end
    end

    def debit(amount)
        raise 'Insufficient balance' if amount > balance

        ActiveRecord::Base.transaction do
            self.balance -= amount
            save!
            Transaction.create!(source_wallet: self, target_wallet: nil, amount: amount, transaction_type: 'debit')
        end
    end

    def transfer_to(target_wallet, amount)
        ActiveRecord::Base.transaction do
            debit(amount)
            Transaction.create!(source_wallet: self, target_wallet: target_wallet, amount: amount, transaction_type: 'transfer')
        end
    end

    def transfering_to(amount)
        ActiveRecord::Base.transaction do
            self.balance += amount
            save!
        end
    end
end
