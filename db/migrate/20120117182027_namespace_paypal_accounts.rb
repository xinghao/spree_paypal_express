class NamespacePaypalAccounts < ActiveRecord::Migration
  def change
    rename_table :paypal_accounts, :spree_paypal_accounts
  end
end
