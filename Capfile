load 'deploy' if respond_to?(:namespace) 

set :application, "Hebreeuws Mattheus"
set :deploy_to, "/var/www/hebreeuwsmattheus.nl"
set :deploy_via, :copy
set :repository, "build" 
set :scm, :none 
set :copy_compression, :gzip
set :use_sudo, false
set :domain, 'hebreeuwsmattheus.nl'
set :user, 'rolf'
set :keep_releases, 5

role :web, 'hebreeuwsmattheus.nl'

before 'deploy:update_code' do
  run_locally 'rm -rf build/*'
  run_locally 'middleman build'
end

namespace 'deploy' do
  task 'finalize_update' do; end
end

after 'deploy:restart', 'deploy:cleanup'
