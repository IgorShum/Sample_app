class CreateMicroposts < ActiveRecord::Migration[6.0]
  def up
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :microposts, :users
    add_index :microposts, [:user_id, :created_at]
  end

  def down
    drop_table :microposts
  end
end
