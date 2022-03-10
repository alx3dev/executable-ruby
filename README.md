# executable-ruby

Cross-compile executables from [rubygems](https://rubygems.org). This is early development, I will do my best to find some free time to continue working on this (to allow script-installers). For now you can make your gem with executable file, and upload it to rubygems. Than you can make static binary in one-line.

# How to install

To keep github repository lightweight, download `golang` on first start. You can either call `bin/setup`, or `exer --getgo` if you install from [rubygems](https://rubygems.org/alx3dev/executable-ruby)

Download and install gem from github:

`git clone https://www.githib.com/alx3dev/executable-ruby`  
`cd executable-ruby`  
`bin/setup`

If you install gem from ruby-gems, you can run:  

`gem install executable-ruby`  
`exer --getgo`

# How to use

Golang is bundled together with gem, and will be removed on uninstall.  
All you need is to run:  

`bin/exer`

or if you install from [rubygems](https://rubygems.org/alx3dev/executable-ruby)

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

# Contribution
This is a work in progress, so please wait to establish some more stable version.
