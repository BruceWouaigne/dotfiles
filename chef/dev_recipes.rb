[
    'curl',
    'apache2',
    'mysql-server',
    'php5',
    'php5-intl',
    'php5-mysql',
    'php5-curl',
    'php5-xdebug',
    'php-apc',
    'php-pear',
    'python',
    'vim',
    'vim-gtk',
    'meld',
    'python-pip',
    'git',
    'tig',
    'inotify-tools',
    'ruby',
    'ruby-dev',
    'exuberant-ctags',
    'tmux',
    'chromium-browser',
    'vlc'
].each do |pkg|
    package pkg do
        action :install
    end
end

service 'apache2' do
    action :start
end

service 'mysql' do
    action :start
end

directory '/home/bruce/dotfiles' do
  owner 'bruce'
  group 'bruce'
  mode '0755'
  action :create
end

directory '/home/bruce/.fonts' do
  owner 'bruce'
  group 'bruce'
  mode '0755'
  action :create
end

git '/home/bruce/dotfiles' do
    user 'bruce'
    group 'bruce'
    repository 'https://github.com/BruceWouaigne/dotfiles.git'
    reference 'master'
    action :sync
end

link '/home/bruce/.vimrc' do
    to '/home/bruce/dotfiles/.vimrc'
end

link '/home/bruce/.tmux.conf' do
    to '/home/bruce/dotfiles/.tmux.conf'
end

link '/home/bruce/.gitconfig' do
    to '/home/bruce/dotfiles/.gitconfig'
end

link '/home/bruce/.gitignore_global' do
    to '/home/bruce/dotfiles/.gitignore_global'
end

link '/home/bruce/.vim' do
    to '/home/bruce/dotfiles/vim'
end

cookbook_file '/home/bruce/.fonts/Droid+Sans+Mono+for+Powerline.otf' do
    action :create
    user 'bruce'
    group 'bruce'
end

execute 'cat /home/bruce/dotfiles/.bashrc >> /home/bruce/.bashrc'
