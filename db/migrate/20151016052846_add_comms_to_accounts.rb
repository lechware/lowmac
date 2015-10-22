class AddCommsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :comms, :string, default: :email # other value is sms
  end
end
