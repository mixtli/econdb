after "deploy:update", "gems:install"
after "gems:install", "db:create"

namespace :deploy do
  desc 'Create deployment directory'
  task :init do
    sudo "mkdir -p -m 775 #{deploy_to}"
    sudo "chown -R #{user} #{deploy_to}"
  end

  desc "Copy public/system to remote"
  task :install_system do
    roles[:app].servers.each do |server|
      `rsync -avz -e "ssh -i $HOME/.ssh/rails_id_rsa" public/system  #{user}@#{server.host}:#{deploy_to}/shared/system`
    end
  end
end
          
namespace :passenger do         
  desc "Restart Application"      
  task :restart, :roles => :app do             
    run "touch #{current_path}/tmp/restart.txt"
  end                
end                  

namespace :gems do   
  desc 'install gems'
  task :install do
    run "cd #{current_path} && #{sudo}  rake RAILS_ENV=#{rails_env} gems:install"
  end
end  

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do passenger.restart end }
end    

namespace :db do
  namespace :migrate do
    desc 'Migrate plugins'
    task :plugins, :roles => :db do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:migrate:plugins"
    end
  end
  namespace :fixtures do 
    desc 'Load seed data into database'
    task :seed, :roles => :db do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:fixtures:seed"
    end
  end
  desc 'Create database'
  task :create do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:create"
  end
end


task :deploy_files do
    require 'tmpdir'
    require 'archive/tar/minitar'    
    begin
      filename = "config_files.tar"
      local_file = "#{Dir.tmpdir}/#{filename}"
      remote_file = "/tmp/#{filename}"
      FileUtils.cd("server_config") do
        File.open(local_file, 'wb') { |tar| Archive::Tar::Minitar.pack(".", tar) }
      end
      put File.read(local_file), remote_file
      sudo "tar xvf #{remote_file} -o -C /"
    ensure
      FileUtils.rm_rf local_file
      run "rm -f #{remote_file}"
    end
end

namespace :gems do
  desc 'install gems'
  task :install do
    run "cd #{current_path} && #{sudo}  rake RAILS_ENV=#{rails_env} gems:install"
  end
end

