class AddRoleToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :role, null: false, default: ''
    end
  end
end
