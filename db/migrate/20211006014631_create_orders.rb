class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :end_user_id
      # t.integer :address_id
      # 追記 ordersテーブルに外部キーaddress_idを持たせる方法
      t.string :name
      t.string :postal_code
      t.string :address

      t.integer :shipping_cost
      t.integer :billing_amount
      t.integer :payment_method, default: 0
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
