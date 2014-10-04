set :application, 'pornfolio'
set :scm, :git
set :repo_url, 'git@github.com:kenchan0130/adultProject.git'
set :deploy_to, '/var/www'
set :user, 'admin'
set :branch, 'master'
set :rails_env, 'production'

set :log_level, :debug
set :sidekiq_role, :app
# set :ssh_options, {
#     keys: [File.expand_path('~/.ssh/id_rsa')],
#     forward_agent: true,
#     auth_methods: %w(publickey)
# }

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}
#set :default_env, {
#    global_gem_home: "/usr/local/bin/gem",
#    gem_home: "$HOME/.gem",
#    gem_path: "$GEM_HOME:$GLOBAL_GEM_HOME",
#    path: "$GEM_HOME/bin:$GLOBAL_GEM_HOME/bin:/usr/bin:$PATH",
#}
#set :deploy_via, :rsync_with_remote_cache
#set :rsync_options, '-az --delete --delete-excluded --exclude=.git'
set :bundle_without, %w{development debug test deployment}.join(' ')
#set :bundle_without, [:development, :test]
set :bundle_flags, '--deployment'
set :bundle_gemfile, -> { release_path.join('Pornofolio/Gemfile') }
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5
namespace :deploy do

end
