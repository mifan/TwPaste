class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      t.string :login, :null => false
      t.string :passwd, :null => false
      t.string :email, :null => false
      t.integer :snippets_count, :null => false, :default => 0
      t.string :bio
      t.string :url
      t.boolean :admin, :default => false

      t.integer :comments_count, :default => 0
      t.timestamps
    end

  end

  def self.down
    drop_table :users
  end
end
