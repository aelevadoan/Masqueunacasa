class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Basic information
      t.string :name
      t.string :slug
      t.text :description
      t.float  :latitude
      t.float  :longitude
      t.string :city
      t.string :country
      t.string :lang
      t.boolean :admin, default: false
      t.string :settings

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :password_digest,    :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :login_count, :default => 0
      t.datetime :last_login_at

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.timestamps

    end

    add_index :users, :email
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :name,                 :unique => true
    add_index :users, :slug,                 :unique => true
  end
end
