namespace :ssl do
  desc "Setup SSL for use in webserver"
  task :setup, roles: :web do
    run "mkdir -p #{shared_path}/ssl"
  end
  after "deploy:setup", "ssl:setup"
end