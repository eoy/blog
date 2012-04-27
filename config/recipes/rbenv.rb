# TASKS:
# rbenv:install - installs and sets up: rbenv, ruby, bundler

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install build-essential curl git-core"

    # installs rbenv
    run "cd $HOME;"
    run "#{sudo} rm -rf .rbenv" # remove if already exists
    run "git clone git://github.com/sstephenson/rbenv.git .rbenv"

    #sets up .bashrc + current environment
    bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then 
  export PATH="$HOME/.rbenv/bin:$PATH" 
  eval "$(rbenv init -)" 
fi
BASHRC
    put bashrc, "/tmp/rbenvrc"
    run "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
    run "mv ~/.bashrc.tmp ~/.bashrc"
    run "rm /tmp/rbenvrc"
    run %q{export PATH="$HOME/.rbenv/bin:$PATH"}
    run %q{eval "$(rbenv init -)"}

    # installs ruby-build
    run "cd $HOME;"
    run "#{sudo} rm -rf ruby-build" # remove if already exists
    run "git clone git://github.com/sstephenson/ruby-build.git"
    run "cd ruby-build; #{sudo} ./install.sh"
    
    # installs ruby
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    
    #installs bundler
    run "gem install bundler --no-ri --no-rdoc"
    run "rbenv rehash"
  end
  after "deploy:install", "rbenv:install"
end