require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/check"
load "config/recipes/nodejs"
#load "config/recipes/ssl"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
load "config/recipes/rbenv"
load "config/recipes/security"

load "config/recipes/utilities"


server "54.247.167.175", :web, :app, :db, primary: true
set :server_name, "tippfuchs.de"
set :application, "blog"

set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:blackbird07/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
#set :port, 22022
#ssh_options[:port] = 22022
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases