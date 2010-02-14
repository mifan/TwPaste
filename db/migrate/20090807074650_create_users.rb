class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    t.string    :login,               :null => true, :default => nil  # optional, you can use email instead, or both
    t.string    :email,               :null => true, :default => nil  # optional, you can use login instead, or both
    t.string    :password,            :null => true

    t.string    :persistence_token,   :null => false                # required
    t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
    t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

    t.string    :oauth_token
    t.string    :oauth_secret


    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
    t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
    t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
    t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
    t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
    t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns

    t.integer   :snippets_count, :null => false, :default => 0
    t.integer   :comments_count, :default => 0

    t.timestamps
    end

    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :oauth_token

  end

  def self.down
    drop_table :users
  end
end
