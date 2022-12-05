class Initial < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :role, default: 0
      t.string :country, default: ''
      t.boolean :confirmed, default: false
      t.string :confirmation_token, default: nil
      t.datetime :confirmation_token_sent_at, default: nil
      t.datetime :deleted_at, default: nil
      t.boolean :recovered, default: false

      t.timestamps
    end

    create_table :passwords do |t|
      t.string :password_digest, null: false
      t.string :reset_password_token, default: nil
      t.datetime :reset_password_token_sent_at, default: nil
      t.datetime :deleted_at, default: nil

      t.timestamps
    end

    create_table :refresh_tokens do |t|
      t.string :token, null: false
      t.datetime :expires_at, null: false
    end

    create_table :user_secrets do |t|
      t.string :secret, null: false
    end

    add_index :users, :confirmation_token, unique: true
    add_index :passwords, :reset_password_token, unique: true

    add_reference :passwords, :user, foreign_key: true, index: true
    add_reference :user_secrets, :user, foreign_key: true, index: true
    add_reference :refresh_tokens, :user, foreign_key: true, index: true
  end
end
