class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps
    end

    add_reference :orders, :address, null: false, foreign_key: true
  end
end
