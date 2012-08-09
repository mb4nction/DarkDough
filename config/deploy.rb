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

namespace :deploy do
  # desc "Insert test data"
  # task :insert_test_data, :roles => :app  do
  #   run "cd #{release_path}; RAILS_ENV=production bundle exec rake db:seed"
  # end

  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:symlink', 'deploy:insert_test_data'
