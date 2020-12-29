class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :x_pos
      t.integer :y_pos
      t.string :facing

      t.timestamps
    end
  end
end
