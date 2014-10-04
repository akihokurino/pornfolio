# Description

This cookbook installs zsh and configures oh-my-zsh framework for the specified users.

# Requirements

This cookbook depends on [zsh](https://github.com/opscode-cookbooks/zsh) and [git](https://github.com/fnichol/chef-git) cookbooks.

# Attributes

* `node['oh-my-zsh']['users']` - users and their settings overrides, e.g.

```
[
  {
    "login": "vaskas",
    "theme": "sorin"
  },
  {
    "login": "root",
    "plugins": ["rvm", "git"]
  },
  {
    "login": "jenkins",
    "home": "/var/lib/jenkins"
  }
]
```

* `node['oh-my-zsh']['theme']` - theme to use for all users unless overridden. Default value is `alanpeabody`.
* `node['oh-my-zsh']['plugins']` - plugins to use for all users unless overridden. Default value is `["git", "ruby", "gem"]`.
* `node['oh-my-zsh']['case_sensitive']` - whether zsh autocompletion should be case-sensitive. Default value is `false`.
* `node['oh-my-zsh']['autocorrect']` - whether command correction should be enabled. Default value is `true`.

# Usage

Include `recipe[oh-my-zsh]` in your run\_list and specify `node['oh-my-zsh']['users']`.
