class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.string     :title, :limit => 80, :null => true
      t.text       :code, :null => false
      t.text       :code_formatted, :null => false
      t.text       :summary_formatted,:null => false
      t.text       :desc 
      t.float      :size, :default => 0
      t.integer    :line_count ,:null => false, :default => 0
      t.integer    :comments_count, :null => false, :default => 0
      t.integer    :views_count, :null => false, :default => 0
      t.boolean    :private, :null => false, :default => false

      t.references :language, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :pastes, :private
    add_index :pastes, :user_id
    add_index :pastes, :language_id
  end

  def self.down
    drop_table :pastes
  end
end
