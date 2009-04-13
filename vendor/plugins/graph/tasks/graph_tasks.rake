namespace :graph do
  desc "Sync extra files from graph plugin."
  task :sync do
    system "rsync -ruv vendor/plugins/graph/db/migrate db"
    system "rsync -ruv vendor/plugins/graph/public ."
  end
end