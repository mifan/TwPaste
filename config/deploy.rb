set :application, "twpaste.com"
set :repository,  "git://github.com/mifan/TwPaste.git"

set :user, "mifan"

set :scm, :git
set :branch, "master"

set :deploy_to, "/home/mifan/#{application}"


role :app, "www.twpaste.com"

namespace :deploy do
  task :start, :roles => :app do
  end

  task :stop, :roles => :app do
  end

  task :restart, :roles => :app do
    run "sudo /etc/init.d/thin  restart"
    end
  
    desc "copy conf files"
    task :before_symlink , :roles => :app do    
        run "cp -f #{shared_path}/config/database.yml #{release_path}/config/"
    end
    
    task :db_migrate , :roles => :app do    
        run "cd #{current_path} && rake db:migrate"
    end


    task :db_migrate_rest , :roles => :app do    
        run "cd #{current_path} && rake db:migrate:reset"
    end

end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
