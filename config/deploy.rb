require 'bundler/capistrano'

set :application, "pfm"
set :deploy_to, "/var/www/apps/pfm"

set :scm, :git
set :repository,  "git@github.com:ekurennyy/pfm_prj.git"

set :deploy_via, :copy
set :copy_strategy, :export

set :deploy_by_user, 'rails@'
set :use_sudo, false

set :ip, 'dev.anahoret.com'

role :web, "#{deploy_by_user}#{ip}"
role :app, "#{deploy_by_user}#{ip}"
role :db,  "#{deploy_by_user}#{ip}", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Insert test data"
  task :insert_test_data, :roles => :app  do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake test_data:insert"
  end

  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# after 'deploy:symlink', 'deploy:insert_test_data'