class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.string :title, :null => false

      t.text :code, :null => false
      t.text :code_formatted, :null => false
      t.text :summary_formatted,:null => false, :default => ""
      t.string :desc 
      t.float :size, :default => 0
      t.integer :line_count ,:null => false, :default => 0
      t.integer :comments_count, :null => false, :default => 0
      t.integer :views_count, :null => false, :default => 0
      t.boolean :private,:null => false, :default => false


      t.references :language
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
