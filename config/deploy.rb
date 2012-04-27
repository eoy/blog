require "bundler/capistrano"

#server "54.247.167.175", :web, :app, :db, primary: true
server "ec2-54-247-167-175.eu-west-1.compute.amazonaws.com", :web, :app, :db, primary: true


set :server_name, "tippfuchs.de"
set :application, "blog"

set :root_user, "ubuntu" # root user that creates deployment user
set :user, "deployer"
set :ssh_public_key, "/home/enrico/.ssh/id_rsa.pub"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:blackbird07/#{application}.git"
set :branch, "master"

set :ruby_version, "1.9.3-p194"

default_run_options[:pty] = true
#set :port, 22022
#ssh_options[:port] = 22022
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# needs to be located after variable definitions, so that variables are available in loaded files

load "config/recipes/base"
load "config/recipes/check"
load "config/recipes/system_user"
load "config/recipes/nodejs"
#load "config/recipes/ssl"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
load "config/recipes/rbenv"
load "config/recipes/security"

load "config/recipes/utilities"