load File.dirname(__FILE__) + "/common_deploy"
default_run_options[:pty] = true
set :repository,  "git@github.com:mixtli/econdb.git"

task :production do
  set :rails_env, "production"
  set :deploy_to, "/mnt/app/econdb"
  set :scm, :git
  #set :scm_passphrase, "whatever"
  set :use_sudo, false
  set :user, "rails"
  set :branch, "master"
  ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh/rails_id_rsa")]
  ssh_options[:forward_agent] = true
  role :app, "dev.ronmcclain.com"
  role :web, "dev.ronmcclain.com"
  role :db,  "dev.ronmcclain.com", :primary => true
  role :memcache, "dev.ronmcclain.com"
end


