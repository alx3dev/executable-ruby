# executable-ruby

Cross-compile executables for gem-install process

# How to install

To keep github repository lightweight, download `golang` on first start. You can call `bin/setup`, or `exer init` if you install from [rubygems](https://rubygems.org/alx3dev/executable-ruby)

Download and install gem from github:

```
git clone https://www.githib.com/alx3dev/executable-ruby \
cd executable-ruby \
bin/setup
```
If you install gem from ruby-gems, you can run:

```
gem install executable-ruby \
exer --setup
```

# How to use
Golang is bundled together with gem, so you can just run it with:

```
bin/exer
```


```ruby

Exer.make(filename: 'glimmer-install', exclude: :darwin) do |x|
  x.add :gem_install, 'glimmer-dsl-libui'
end
```

```ruby
Exer.make do |app|
  app.filename = 'glimmer-dsl-libui'
  app.add :binary_exist, 'git'
  app.add :gem_install, 'glimmer-dsl-libui'
end
```

# Contribution
This is a work in progress, so please wait to establish some more stable version.
