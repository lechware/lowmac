class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,             null: false, default: ""
      t.string :email,            null: false, default: ""
      t.string :phone,            null: false, default: ""
      t.string :address,          null: false, default: ""
      t.string :business_number,  null: false, default: ""

      t.timestamps null: false
    end
  end
end
