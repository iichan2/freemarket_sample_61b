# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.11.2'

# Capistranoのログの表示に利用する
set :application, 'freemarket_sample_61b'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:iichan2/freemarket_sample_61b.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/mercari61b.pem']  

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :db_seed do
    on roles(:db) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :rake, :'db:seed'
        end
      end
    end
  end
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:stop'
      invoke 'unicorn:start'
    end
  end
  after :finishing, 'deploy:cleanup'
end

set :default_env, {
  BASIC_AUTH_USER: ENV["BASIC_AUTH_USER"],
  BASIC_AUTH_PASSWORD: ENV["BASIC_AUTH_PASSWORD"]
}
