load 'deploy' if respond_to?(:namespace)

set :application, 'tasket'
set :user, 'sinatra'
set :domain, '209.20.80.6'
ssh_options[:port] = 4330

default_run_options[:pty] = true
set :scm, :git
set :scm_passphrase, "centeroftheearth"
set :repository,  'git@github.com:bisceglie/tasket.git'
set :deploy_via, :remote_cache
set :deploy_to, "/home/sinatra/#{application}"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

role :app, "209.20.80.6"
role :web, "209.20.80.6"
role :db,  "209.20.80.6", :primary => true

set :runner, user
set :admin_runner, user

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru start"
  end
	
  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru stop"
  end
	
  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end
	
  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.restart
  end
end

namespace :iwrtw do
  task :log do
    run "cat #{deploy_to}/current/log/thin.log"
  end
end