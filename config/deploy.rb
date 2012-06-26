require 'bundler/capistrano'
require "rvm/capistrano"                         # Load RVM's capistrano plugin.

set :application, "pfm"
set :deploy_to, "/var/www/apps/pfm"

set :scm, :git
set :repository,  "git@github.com:mb4nction/DarkDough.git"
set :branch, 'master'
set :deploy_via, :copy
set :copy_strategy, :export

set :deploy_by_user, 'rails'
set :use_sudo, false
set :rails_env, 'production'

set :ip, 'dev.anahoret.com'

# rvm-capistrano gem
set :rvm_ruby_string, '1.9.3@pfm'
set :rvm_type, :system                           # defaults to using a user installation of rvm

role :web, "#{deploy_by_user}@#{ip}"
role :app, "#{deploy_by_user}@#{ip}"
role :db,  "#{deploy_by_user}@#{ip}", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Insert test data"
  task :insert_test_data, :roles => :app  do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake db:seed"
  end

  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :rvm do
  set :passenger_standalone_port, 3035

  desc "trust .rvmrc in new release directory"
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end

  desc "(Re)start Phusion Passenger Standalone (is used by Apache as a reverse proxy)."
  task :restart_passenger_standalone do
    run "if [[ -s #{current_release}/tmp/pids/passenger.#{passenger_standalone_port}.pid ]]; then cd #{current_release} && passenger stop -p #{passenger_standalone_port}; fi"
    run "cd #{current_release} && passenger start -a 127.0.0.1 -p #{passenger_standalone_port} -d -e #{rails_env}"
  end
end

# after 'deploy:symlink', 'deploy:insert_test_data'

after "deploy:create_symlink", "rvm:trust_rvmrc"
after 'deploy:create_symlink', 'rvm:restart_passenger_standalone'

