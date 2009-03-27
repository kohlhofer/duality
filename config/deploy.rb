# app stuff
set :application, "duality"
set :deploy_to,   "/home/rockorpop"
set :use_sudo,    false

# ssh stuff
default_run_options[:pty] = true
set :user, "rockorpop"
set :ssh_options, { :forward_agent => true }

# git
set :scm,         "git"
set :repository,  "git@github.com:kohlhofer/duality.git"
set :branch,      "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

# servers
role :app, "meat.teamschnitzel.net"
role :web, "meat.teamschnitzel.net"
role :db,  "meat.teamschnitzel.net", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :rockorpop do
  task :copy_database_configuration do 
    run "cp #{deploy_to}/shared/database.yml #{latest_release}/config/" 
  end
end

after 'deploy:update_code',  'rockorpop:copy_database_configuration'
