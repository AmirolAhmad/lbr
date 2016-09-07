set :application, 'lbr_production'
set :stage, :production
set :rails_env, :production
set :deploy_to, '/home/deploy/lbr_production'
set :release_note_url, 'http://lbr.org.my/release_note.txt'

server '128.199.158.13', user: 'deploy', roles: %w{web app db job}
