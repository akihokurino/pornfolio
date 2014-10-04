unless node['oh-my-zsh']['users'].empty?
  include_recipe 'zsh'
end

node['oh-my-zsh']['users'].each do |hash|
  login = hash['login']
  home  = hash['home'] || (login == "root" ? "/root" : "/home/#{login}")

  git "#{home}/.oh-my-zsh" do
    repository 'git://github.com/robbyrussell/oh-my-zsh.git'
    user       login
    reference  'master'
    action     :sync
  end

  template "#{home}/.zshrc" do
    source 'zshrc.erb'
    owner login
    mode '644'
    variables({
      :user           => login,
      :theme          => hash['theme']          || node['oh-my-zsh']['theme'],
      :case_sensitive => hash['case_sensitive'] || node['oh-my-zsh']['case_sensitive'],
      :plugins        => hash['plugins']        || node['oh-my-zsh']['plugins'],
      :autocorrect    => node['oh-my-zsh']['autocorrect']
    })
  end

  template "#{home}/.zshrc.alias" do
    source 'zshrc.alias.erb'
    owner login
    mode '644'
  end

  user login do
    action :modify
    shell '/bin/zsh'
  end

  execute 'source /etc/profile to all zshrc' do
    command "echo 'source /etc/profile' >> /etc/zsh/zprofile"
    not_if  "[[ ! -f /etc/zsh/zprofile ]] || grep 'source /etc/profile' /etc/zsh/zprofile"
  end
end
