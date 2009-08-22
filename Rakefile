require 'rubygems'
require 'sinatra'
require 'dm-core'
require "spec/rake/spectask"

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList["spec/*_spec.rb"]
end

namespace :db do
  require 'config/database'

  desc "Migrate the database"
  task :migrate do
    DataMapper.auto_migrate!
  end
  
  desc "Add admin users"
  task :adminusers do
    us = User.new
    us.login = "admin"
    us.email = "me@alexbisceglie.com"
    us.password = "foobar"
    us.save
    
  end
  
  desc "Add some test users"
  task :testusers do
    us = User.new
    us.login = "test"
    us.email = "asdf@asdf.de"
    us.password = "pw"
    us.save

    as = User.new
    as.login = "foo"
    as.email = "yes@asd.de"
    as.password = "bar"
    as.save
  end
  
  desc "Add some test tasks"
  task :testtasks do
    t = Task.new
    t.tasked_id = 1
    t.body = "create tasks"
    t.save
  end
end
