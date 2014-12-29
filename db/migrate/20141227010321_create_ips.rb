class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.integer :user_id
      t.string :current_ip
      t.string :last_sign_in_ip

      t.timestamps
    end
  end
end
