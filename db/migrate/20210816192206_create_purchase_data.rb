class CreatePurchaseData < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_data do |t|
      t.string :cpf
      t.integer :private_purchase
      t.integer :incomplete
      t.datetime :date_of_last_purchase
      t.float :average_ticket
      t.float :last_purchase_ticket
      t.string :most_frequent_store
      t.string :last_purchase_store

      t.timestamps
    end
  end
end
