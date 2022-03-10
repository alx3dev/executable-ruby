# executable-ruby

Cross-compile executables from [rubygems](https://rubygems.org).  
This is early development, I will do my best to find some free time to continue working on this (to allow script-installers). For now you can make your gem with executable file, and upload it to rubygems. Than you can make static binary in one-line.

# How to install

To keep github repository lightweight, download `golang` on first start. You can either call `bin/setup`, or `exer --getgo` if you install from [rubygems](https://rubygems.org/alx3dev/executable-ruby)

Download and install gem from github:

`git clone https://www.githib.com/alx3dev/executable-ruby`  
`cd executable-ruby`  
`bin/setup`

If you install gem from ruby-gems, you can run:  

`gem install executable-ruby`  
`exer --getgo`

If you don't want to install golang, you can use system installed one:

```ruby  
Exer.system_golang = true
```

# How to use

You can read [documentation on rubydoc](https://rubydoc.info/gems/executable-ruby)  

To start gem run:  

`bin/exer`

or if you install from [rubygems](https://rubygems.org/alx3dev/executable-ruby/0.2.0)

`exer`


Make your gem with executable script in `bin` directory, named same as your gem. (If your gem name is `gem-name`, create file `bin/gem-name`, without `.rb`).

Now you can use `:gem_run` to make executable that will run your gem, with `gem install` command if gem was not found on the system.

```ruby  
Exer.make(filename: 'my_new_gem_run') do |app|
  app.add :gem_run, 'my_new_gem'
end
```  

Make binary to only install gem(s), but don't forget to add `wait_for_enter`:

```ruby  
Exer.make do |app|
  # you can use shortcut for filename=
  app >> 'my-gem-name-install'
  app.add :gem_install, 'my-gem-name'
  app.wait_for_enter
end
```  

# License

Executable Ruby is registered under the GPL-v3 license, but you are also allowed to **build binaries with this gem** for `MIT`, `Apache2` and `OpenBSD` license. You are not allowed to use source-code or it's parts in your application (unless licensed under GPL), but you are allowed to build static binaries for your `MIT, Apache2 or OpenBSD` licensed gem.

# Tested on:

Gem tested on:
 - `Linux Mint 20.2 - Uma`
 - `Ubuntu 20.04.4`
 - `Ubuntu 21.10`

Binaries tested on:
 - `Windows 10 Home 64bit`
 - `Windows 10 Pro 64bit`
 - `Linux Mint 20.2 - Uma`
 - `Ubuntu 20.04.4`
 - `Ubuntu 21.10`
 - `MacOS 11`
 
# Contribution
This is a work in progress, so please wait to establish some more stable version.
