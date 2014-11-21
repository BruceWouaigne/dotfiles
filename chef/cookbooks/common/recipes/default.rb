[
    'curl',
    'apache2',
    'mysql-server',
    'php5',
    'php5-dev',
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
    'pepperflashplugin-nonfree',
    'vlc',
    'ubuntu-tweak',
    'light-themes',
    'mysql-workbench'
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

directory '/home/bruce/.fonts' do
  owner 'bruce'
  group 'bruce'
  mode '0755'
  action :create
end

rootdir = run_context.cookbook_collection[cookbook_name].root_dir + '/../../..'

link '/home/bruce/.fonts/Droid+Sans+Mono+for+Powerline.otf' do
    to rootdir + '/fonts/Droid+Sans+Mono+for+Powerline.otf'
end

link '/home/bruce/.fonts/DejaVuSansMono-Powerline.ttf' do
    to rootdir + '/fonts/DejaVuSansMono-Powerline.ttf'
end

execute 'cd ' + rootdir + ' && git submodule update --init'

link '/home/bruce/.vim' do
    to rootdir + '/vim'
end

link '/home/bruce/.vimrc' do
    to rootdir + '/vim/.vimrc'
end

execute 'cd ' + rootdir + '/vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make'

git '/home/bruce/tmux-powerline' do
  repository 'https://github.com/BruceWouaigne/tmux-powerline.git'
  user 'bruce'
  group 'bruce'
end

link '/home/bruce/.tmux.conf' do
    to rootdir + '/tmux/.tmux.conf'
end

link '/home/bruce/.gitconfig' do
    to rootdir + '/git/.gitconfig'
end

link '/home/bruce/.gitignore_global' do
    to rootdir + '/git/.gitignore_global'
end

execute 'cat ' + rootdir + '/bash/.bashrc >> /home/bruce/.bashrc'
execute 'fc-cache -vf'
execute 'curl -sSL https://get.docker.com/ubuntu/ | sh'
execute 'curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin'
