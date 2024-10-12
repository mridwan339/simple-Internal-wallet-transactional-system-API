class Transaction < ApplicationRecord
    belongs_to :source_wallet, class_name: 'Wallet', optional: true
    belongs_to :target_wallet, class_name: 'Wallet', optional: true

    validates :amount, numericality: { greater_than: 0 }
    validate :validate_wallets

    private

    def validate_wallets
        if transaction_type == 'credit' && source_wallet_id.present?
        errors.add(:source_wallet, 'should be nil for credit transactions')
        elsif transaction_type == 'debit' && target_wallet_id.present?
        errors.add(:target_wallet, 'should be nil for debit transactions')
        elsif transaction_type == 'transfer' && (source_wallet_id.nil? || target_wallet_id.nil?)
        errors.add(:base, 'Source and target wallets are required for transfer transactions')
        end
    end
end
