# executable-ruby

Cross-compile executables for gem-install process

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


```ruby
Exer.make do |app|
  # name of end binaries (_install will be appedned)
  app.filename = 'glimmer-dsl-libui'
  # check if git is installed on the system
  app.add :binary_exist, 'git'
  # run gem install
  app.add :gem_install, 'glimmer-dsl-libui'
end
```

# Contribution
This is a work in progress, so please wait to establish some more stable version.
