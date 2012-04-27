def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

## https://github.com/bsutic/blog/blob/master/config/recipes/base.rb
def close_sessions  # method is needed when changing user from root to deployer. Sessions need to close
  sessions.values.each { |session| session.close }
  sessions.clear
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} bash -c 'echo Europe/Berlin > /etc/timezone'"
    run "#{sudo} cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime"
    run "#{sudo} dpkg-reconfigure -f noninteractive tzdata"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
  end
  #before "deploy:install", "system_user:create_user" # creates deployer user and sets up SSH keys
end